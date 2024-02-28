//
//  Coingecko.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation

struct SearchAPI: Decodable {
    var coins: [Coin]
}

struct Coin: Decodable {
    var id, name, symbol, thumb: String
}
