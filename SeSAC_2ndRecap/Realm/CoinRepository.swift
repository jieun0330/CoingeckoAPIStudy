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
    // 즐겨찾기했을 경우 Realm에 저장
    func createFavoriteItem(_ data: CoinRealmModel) {
        do {
            try realm.write {
                realm.add(data)
//                print(realm.configuration.fileURL)
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
    
    // Realm에 해당 이름이 있는지 확인 -> 즐겨찾기 star 표시
    func readItemName(item: String) -> Results<CoinRealmModel> {
        return realm.objects(CoinRealmModel.self).where {
            $0.name == item
        }
    }
    
    // 이렇게 해도 문제 없으려나?
//    func itemFilter() -> Results<CoinRealmModel> {
//        return realm.objects(CoinRealmModel.self)
//    }
    
    // Update
    
    // Delete
    func deleteItem(item: CoinRealmModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            
        }
    }
}
