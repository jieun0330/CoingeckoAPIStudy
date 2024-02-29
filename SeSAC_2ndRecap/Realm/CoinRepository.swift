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
    
    func createFavoriteItem(name: String) {
        let item = CoinRealmModel(name: name)
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
//    func updateFavoriteItem(item: CoinRealmModel) {
//        do {
//            try realm.write {
//                item.favorites.toggle()
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    // Read
    
    func itemFilter(name: String) -> Results<CoinRealmModel> {
        return realm.objects(CoinRealmModel.self).where {
            $0.name == name
        }
    }
    
//    func fetchAllItem(name: String) -> [CoinRealmModel] {
//        let result = realm.objects(CoinRealmModel.self)
//        return Array(result)
//    }
    
//    func fetchSearchedItem() -> [CoinRealmModel] {
//        let result = realm.objects(CoinRealmModel.self)
//        return Array(result)
//    }
    
    
//    func updateFavoriteItem(_ item: CoinRealmModel) {
//        do {
//            try realm.write {
//                item.favorites.toggle()
//            }
//        } catch {
//            print(error)
//        }
//    }
    
//    func favoriteItemsFilter() -> Results<CoinRealmModel> {
//        return realm.objects(CoinRealmModel.self).where {
//            $0.favorites == true
//        }
//    }

}
