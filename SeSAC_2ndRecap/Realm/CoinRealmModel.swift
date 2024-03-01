//
//  RealmModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import Foundation
import RealmSwift

class CoinRealmModel: Object {
    @Persisted(primaryKey: true) var id: String
//    @Persisted var name: String
//    @Persisted var favorites: Bool
//    @Persisted var symbol: String
//    @Persisted var currentPrice: Int
    
    convenience init(id: String) {
        self.init()
//        self.id = id
        self.id = id
//        self.favorites = false
//        self.symbol = symbol
//        self.currentPrice = currentPrice
    }
}
