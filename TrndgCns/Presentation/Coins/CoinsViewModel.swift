//
//  CoinsViewModel.swift
//  TrndgCns
//
//  Created by MacBook Air on 20.05.2023.
//

import Foundation
import Combine

protocol CoinsViewModelProtocol {
    func getData(keyword: String)
    func pageDidLoad(data: Coins)
    func willDisplay(itemAtIndex index: Int)
    func requestNewPage()
}

class CoinsViewModel: CoinsViewModelProtocol {
    
    var coins = CurrentValueSubject<Coins, Never>(Coins(data: [], timestamp: nil))
    
    private enum Constants {
        static let pageItemsLimit = 10
    }
    
    let objectNetworkService = CoinService()
    var elements: Coins = Coins(data: [], timestamp: nil)
    
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - Variables for pagination
    
    private var offset = 0
    private var isNeedToRequestMore = true
    private var searchKeyword: String = ""
    private var maxRequestedIndex: Int = -1
    private var isLoading: Bool = false
    private var newPageShouldBeRequested: Bool = false
    
    init(coins: CurrentValueSubject <Coins, Never> = CurrentValueSubject<Coins, Never>(Coins(data: [], timestamp: nil))) {
        self.coins = coins
    }
    
    //Search VS PageLoad
    
    func getData(keyword: String) {
        do {
            if self.searchKeyword != keyword {
                isNeedToRequestMore = true
                elements.data = []
                maxRequestedIndex = -1
                newPageShouldBeRequested = false
                offset = 0
                cancellable.forEach({ $0.cancel() })
            }
            self.searchKeyword = keyword

            if isNeedToRequestMore {
                let data = try objectNetworkService.getList(by: self.searchKeyword, limit: Constants.pageItemsLimit, offset: offset)
                data
                    .subscribe(on: DispatchQueue.global(qos: .background))
                    .receive(on: RunLoop.main)
                    .map { element -> Coins in
                        self.pageDidLoad(data: element)
                        return element
                    }
                    .replaceError(with: Coins(data: [], timestamp: nil))
                    .sink(receiveValue: { [weak self] returnedCoins in
                        guard let self = self else {
                            return
                        }
                        self.elements.data.append(contentsOf: returnedCoins.data)
                        self.coins.send(self.elements)
                    })
                
                    .store(in: &cancellable)
            }
        } catch let error {
            print("\(error) Error")
        }
    }
    
    //Pagination

    func pageDidLoad(data: Coins) {
        if data.data.isEmpty {
            self.isNeedToRequestMore = false
        }
        self.isLoading = false
        self.offset = self.coins.value.data.count
        //self.offset += self.offset + data.data.count
        if newPageShouldBeRequested {
            requestNewPage()
        }
    }
    
    func willDisplay(itemAtIndex index: Int) {
        guard index + Constants.pageItemsLimit > maxRequestedIndex else {
            newPageShouldBeRequested = false
            return
        }

        guard isLoading == false else {
            newPageShouldBeRequested = true
            return
        }
        requestNewPage()
    }

    func requestNewPage() {
        isLoading = true
        maxRequestedIndex = elements.data.count + Constants.pageItemsLimit
        getData(keyword: searchKeyword)
    }
}
