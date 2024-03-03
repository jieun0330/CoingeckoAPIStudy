//
//  API.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import Foundation

enum CoinAPI {
    case search(query: String)
    case market(query: String)
    case trending
    
    var baseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var endpoint: URL {
        switch self {
        case .search(let query):
            return URL(string: "\(baseURL)search?query=\(query)")!
        case .market(let query):
            return URL(string: "\(baseURL)coins/markets?vs_currency=krw&ids=\(query)")!
        case .trending:
            return URL(string: "\(baseURL)search/trending")!
        }
    }
}
