//
//  DetailViewModel.swift
//  TrndgCns
//
//  Created by MacBook Air on 29.05.2023.
//

import Foundation
import Combine
import UIKit

class DetailViewModel {
    var coin: Datum
    
    init(coin: Datum) {
        self.coin = coin
    }

    var priceUSDPublisher = CurrentValueSubject<String, Never>("")
    var percentPublisher = CurrentValueSubject<String, Never>("")
    var priceDifferencePublisher = CurrentValueSubject<String, Never>("")
    var marketCapNumberPublisher = CurrentValueSubject<String, Never>("")
    var supplyNumberPublisher = CurrentValueSubject<String, Never>("")
    var volume24HrNumberPublisher = CurrentValueSubject<String, Never>("")
    var nameOfCurrencyPublisher = CurrentValueSubject<String, Never>("")
    
    var colorPublisher = CurrentValueSubject<UIColor.Type, Never>(UIColor.self)
    
    
    
    func sendData() {
        priceUSDPublisher.send("$\(coin.price.asCurrencyWith2Decimals())")
        percentPublisher.send("\(coin.changePercent.asPercentString())")
        priceDifferencePublisher.send("\(coin.priceDifference.asCurrencyWith2Decimals())")
        marketCapNumberPublisher.send("$\(coin.marketCapBillion.asCurrencyWith2Decimals())b")
        supplyNumberPublisher.send("\(coin.supplyMillion.asCurrencyWith2Decimals())m")
        volume24HrNumberPublisher.send("$\(coin.volumeBillion.asCurrencyWith2Decimals())b")
        nameOfCurrencyPublisher.send(coin.nameCoin)
        
    }
}
