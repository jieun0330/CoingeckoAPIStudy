//
//  Coingecko.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation

// Coingecko.coins로 접근을 해야 Coin 배열안을 접근할 수 있다 ?
struct SearchAPI: Decodable {
    var coins: [Coin]
}

struct Coin: Decodable {
    var id, name, symbol, thumb: String
}
