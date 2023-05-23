//
//  CoinService.swift
//  TrndgCns
//
//  Created by MacBook Air on 20.05.2023.
//

import Foundation
import Combine

//Custom Errors
enum NetworkError: Error, CustomStringConvertible {
    case custom(String)
    case emptyData
    case wrongJson(String)
    case wrongURL
    case wrongParameters

    var description: String {
        switch self {
        case .custom(let text):
            return text
        case .emptyData:
            return "empty data"
        case .wrongJson(let json):
            return "wrong json - \(json)"
        case .wrongURL:
            return "wrong URL"
        case .wrongParameters:
            return "wrong params"
        }
    }
}

final class CoinService {

    //Getting pagination
    func getList(by keyword: String, limit: Int = 100, offset: Int = 0) throws -> AnyPublisher<Coins, Error> {
        let urlString = Constants.fullURL

        guard var url = URL(string: urlString ) else { throw NetworkError.wrongURL }

        var items = [URLQueryItem]()
        let limitItem = URLQueryItem(name: "limit", value: "\(limit)")
        if !keyword.isEmpty {
            let keywordItem = URLQueryItem(name: "search", value: keyword)
            items.append(keywordItem)
        }
        items.append(limitItem)
        if offset > 0 {
            let offsetItem = URLQueryItem(name: "offset", value: "\(offset)")
            items.append(offsetItem)
        }
        url.append(queryItems: items)
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .decode(type: Coins.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
