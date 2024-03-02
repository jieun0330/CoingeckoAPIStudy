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
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
