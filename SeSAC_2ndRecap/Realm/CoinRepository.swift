//
//  CoinRepository.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import Foundation
import RealmSwift

class CoinRepository {
    
    private let realm = try! Realm()
    
    // Create
    func createFavoriteItem(_ data: CoinRealmModel) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    // Read
    func fetchAllItem() -> [CoinRealmModel] {
        let result = realm.objects(CoinRealmModel.self)
        return Array(result)
    }
    
    func itemFilter(item: String) -> Results<CoinRealmModel> {
        return realm.objects(CoinRealmModel.self).where {
            $0.name == item
        }
    }
    
    // Update
    
    // Delete
}
