//
//  TrendingAPI.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import Foundation

struct Trending: Decodable {
    let coins: [Coin]
    let nfts: [Nft]
    let categories: [Category]
}

struct Category: Decodable {
    let id: Int
    let name: String
    let marketCap1HChange: Double
    let slug: String
    let coinsCount: Int
    let data: CategoryData
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case marketCap1HChange = "market_cap_1h_change"
        case slug
        case coinsCount = "coins_count"
        case data
    }
}

struct CategoryData: Decodable {
    let marketCap, marketCapBtc, totalVolume, totalVolumeBtc: Double
    let marketCapChangePercentage24H: [String: Double]
    let sparkline: String
    
    enum CodingKeys: String, CodingKey {
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case sparkline
    }
}

struct Coin: Decodable {
    let item: Item
}

struct Item: Decodable {
    let id: String
    let coinID: Int
    let name, symbol: String
    let marketCapRank: Int?
    let thumb, small, large: String
    let slug: String
    let score: Int
    let data: ItemData
    
    enum CodingKeys: String, CodingKey {
        case id
        case coinID = "coin_id"
        case name, symbol
        case marketCapRank = "market_cap_rank"
        case thumb, small, large, slug
        case score, data
    }
}

struct ItemData: Decodable {
    let price: Double
    let priceBtc: String
    let priceChangePercentage24H: PriceChangePercentage
    let marketCap, marketCapBtc, totalVolume, totalVolumeBtc: String
    let sparkline: String
    let content: Content?
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceBtc = "price_btc"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case marketCapBtc = "market_cap_btc"
        case totalVolume = "total_volume"
        case totalVolumeBtc = "total_volume_btc"
        case sparkline, content
    }
}

struct Content: Decodable {
    let title, description: String
}

struct Nft: Decodable {
    let id, name, symbol: String
    let thumb: String
    let nftContractID: Int
    let nativeCurrencySymbol: String
    let floorPriceInNativeCurrency, floorPrice24HPercentageChange: Double
    let data: NftData
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, thumb
        case nftContractID = "nft_contract_id"
        case nativeCurrencySymbol = "native_currency_symbol"
        case floorPriceInNativeCurrency = "floor_price_in_native_currency"
        case floorPrice24HPercentageChange = "floor_price_24h_percentage_change"
        case data
    }
}

struct NftData: Decodable {
    let floorPrice, floorPriceInUsd24HPercentageChange, h24Volume, h24AverageSalePrice: String
    let sparkline: String
//    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case floorPriceInUsd24HPercentageChange = "floor_price_in_usd_24h_percentage_change"
        case h24Volume = "h24_volume"
        case h24AverageSalePrice = "h24_average_sale_price"
        case sparkline
//        case content
    }
}

struct PriceChangePercentage: Decodable {
    let krw: Double
}
