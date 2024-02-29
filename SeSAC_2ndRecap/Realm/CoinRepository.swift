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
    
    // Crate
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
    func fetchAllItem() -> [CoinRealmModel] {
        let result = realm.objects(CoinRealmModel.self)
        return Array(result)
    }
    
    func itemFilter(name: String) -> Results<CoinRealmModel> {
        return realm.objects(CoinRealmModel.self).where {
            $0.name == name
        }
    }
    
    // Delete
    func deleteItem(_ item: CoinRealmModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    

    
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
