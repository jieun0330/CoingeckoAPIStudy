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
//                item.favorites.toggle()
//                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    func updateFavoriteItem(item: CoinRealmModel) {
        do {
            try realm.write {
                item.favorites.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    
//    func updateFavoriteItem(_ item: CoinRealmModel) {
//        do {
//            try realm.write {
//                item.favorites.toggle()
//            }
//        } catch {
//            print(error)
//        }
//    }
    
    func favoriteItemsFilter() -> Results<CoinRealmModel> {
        return realm.objects(CoinRealmModel.self).where {
            $0.favorites == true
        }
    }
    
//    func favoriteItemFilter(item: CoinModel) -> Results<CoinModel>{
//        return realm.objects(CoinModel.self).where {
//            $0.name.contains(item.name, options: .caseInsensitive)
//        }
//    }
    
}
