//
//  API.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import Foundation
import Alamofire

enum CoinAPI {
    case search(query: String)
    case market(query: [String])
    case trending
    
    var baseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var endpoint: String {
        switch self {
        case .search(let query):
            return baseURL + "search"
        case .market(let query):
            return baseURL + "coins/markets"
        case .trending:
            return baseURL + "search/trending"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .search(let query):
            return ["query": query]
        case .market(let query):
            return ["vs_currency": "krw",
                    "ids": query.joined(separator: ","),
                    "sparkline": "true"]
        case .trending:
            return ["": ""]
        }
    }
}
