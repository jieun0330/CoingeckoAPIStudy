//
//  Coingecko.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation

struct Search: Decodable {
    var coins: [SearchAPI]
}

struct SearchAPI: Decodable {
    var id, name, symbol, thumb, large: String
}
