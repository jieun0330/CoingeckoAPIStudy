//
//  SearchViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation
import RealmSwift

class SearchViewModel {
    
    var inputSearchBarTapped = Observable("")
    var inputDidSelectRow = Observable("")
    
    var outputCoinInfoData: Observable<[InfoAPI]> = Observable([])
    var outputCoinPriceData: Observable<PriceAPI> = Observable([])
    
    /*
     https://cyndi0330.tistory.com/40
     프로퍼티 옵저버가 struct에서만 동작하는 이유를 이해못하다보니 적어봤는데 혹시 틀린 부분이 있으면 말씀 부탁드립니다~!
     */
    
    init() {
        
        // 검색했을 때
        inputSearchBarTapped.bind { string in
            APIManager.shared.fetchCoinAPI(completionHandler: { value in
                self.outputCoinInfoData.value = value.coins
            }, query: string)
        }
        
        inputDidSelectRow.bind { value in
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
                self.outputCoinPriceData.value = data
            }, query: value)
        }
    }
}
