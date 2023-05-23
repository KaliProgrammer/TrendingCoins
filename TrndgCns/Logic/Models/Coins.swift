//
//  Coins.swift
//  TrndgCns
//
//  Created by MacBook Air on 20.05.2023.
//

import Foundation

// MARK: - Coins
struct Coins: Codable {
    var data: [Datum]
    let timestamp: Int?
}

// MARK: - Datum
struct Datum: Codable {
    let id, rank, symbol, name: String
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr, vwap24Hr: String?
}

//Computed property for Coins
extension Datum {
    var price: Double {
        Double(priceUsd ?? "") ?? 0.0
    }
    
    var changePercent: Double {
        Double(changePercent24Hr ?? "") ?? 0.0
    }
    
    var priceDifference: Double {
        (price * changePercent)/100
    }
    
    var marketCap: Double {
        Double(marketCapUsd ?? "") ?? 0.0
    }
    
    var marketCapBillion: Double {
        marketCap/1000_000_000
    }
    
    var marketCapText: String {
        "Market Cap"
    }
    
    var supplyUSD: Double {
        Double(supply ?? "") ?? 0.0
    }
    
    var supplyMillion: Double {
        supplyUSD/1000_000
    }
    
    var supplyText: String {
        "Supply"
    }
    
    var volumeUSD: Double {
        Double(volumeUsd24Hr ?? "") ?? 0.0
    }
    
    var volumeBillion: Double {
        volumeUSD/1000_000_000
    }
    
    var volumeTextUSD: String {
        "Volume 24Hr"
    }
    
    var nameCoin: String {
        return name
    }
    
}

