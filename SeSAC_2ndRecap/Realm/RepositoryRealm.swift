//
//  CoinRepository.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import Foundation
import RealmSwift

final class RepositoryRealm {
    
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
//            print(error)
        }
    }
    
    // Read All
    func fetchAllItem() -> [CoinRealmModel] {
        let result = realm.objects(CoinRealmModel.self)
        return Array(result)
    }
    
    // Realm에 해당 이름이 있는지 확인 -> 즐겨찾기 star 표시
    func readItemName(id: String) -> Results<CoinRealmModel> {
        return realm.objects(CoinRealmModel.self).where {
            $0.id == id
        }
    }
    
    // Update
    
    // Delete
    func deleteItem(item: CoinRealmModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
//            print(error)
        }
    }
}
