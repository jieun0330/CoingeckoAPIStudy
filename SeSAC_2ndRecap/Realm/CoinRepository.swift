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
    func createFavoriteItem(_ data: CoinRealmModel) {
//        let item = CoinRealmModel(name: name)
        
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
//    func itemFilter(_ item: CoinRealmModel) -> Results<CoinRealmModel> {
//        return realm.objects(CoinRealmModel.self).where {
//            $0.name.contains(item.name)
//            $0.title.contains(item.title, options: .caseInsensitive) // caseInsensitive: 대소문자 구별 없음
//        }
//    }
    
//    func readRecordAllFilter() -> Results<ReminderMainModel> {
//        return realm.objects(ReminderMainModel.self).where {
//            $0.complete == false
//        }
//        // ascending: 내림차순, 올림차순 정렬
//    }
    
    
    
    // Update
    func updateFavoriteItem(item: CoinRealmModel) {
        do {
            try realm.write {
                item.favorites.toggle()
            }
        } catch {
            print(error)
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
