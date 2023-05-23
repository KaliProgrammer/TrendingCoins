//
//  CoinLogoService.swift
//  TrndgCns
//
//  Created by MacBook Air on 20.05.2023.
//

import Foundation
import Combine
import UIKit

protocol CoinLogoServiceProtocol: AnyObject {
    func getData(by symbol: String)
}

class CoinLogoViewModel: CoinLogoServiceProtocol {
    let coin: Datum
    var cancellable = Set<AnyCancellable>()
    var coinImage = CurrentValueSubject<UIImage?, Never>(nil)
    
    init(coin: Datum) {
        self.coin = coin
        getData(by: coin.symbol)
    }
    
    //MARK: - Recieving coin's logo
    
    func getData(by symbol: String) {
        let urlString = "https://coinicons-api.vercel.app/api/icon/\(symbol.lowercased())"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { data in
                if let image = UIImage(data: data) {
                    self.coinImage.send(image)
                }
            })
            .store(in: &cancellable)
       }
    }

