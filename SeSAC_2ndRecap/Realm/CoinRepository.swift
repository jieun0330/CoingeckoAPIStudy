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
    
    func createItem(name: String) {
        
        let item = CoinModel(name: name)
        
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
}
