//
//  RealmModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import Foundation
import RealmSwift

class CoinRealmModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var favorites: Bool
    
    convenience init(name: String) {
        self.init()
        self.name = name
        self.favorites = false
    }
}
