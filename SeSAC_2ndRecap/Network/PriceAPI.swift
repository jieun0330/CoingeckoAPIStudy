//
//  MarketAPI.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/29/24.
//

import Foundation

struct Price: Decodable {
    var id, symbol, name: String
    let image: String
    let currentPrice: Int
    let high24H, low24H: Int
    let priceChangePercentage24H: Double
    let ath: Int
    let athDate: String
    let roi: Roi?
    let lastUpdated: String

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case ath
        case athDate = "ath_date"
        case roi
        case lastUpdated = "last_updated"
    }
}

struct Roi: Codable {
    let times: Double
    let currency: String
    let percentage: Double
}

typealias PriceAPI = [Price]
