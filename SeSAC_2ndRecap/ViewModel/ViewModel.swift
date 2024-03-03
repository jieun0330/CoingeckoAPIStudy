//
//  ViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/2/24.
//

import Foundation

final class ViewModel {
    
    // Search 화면
    var inputSearchBarTapped = Observable("")
    // Trending 화면, Favorite 화면
    var inputViewTrigger = Observable("")
    
    var outputCoinInfoAPI: Observable<[InfoAPI]> = Observable([])
    var outputCoinPriceAPI: Observable<PriceAPI> = Observable([])
    
    init() {
        // 검색했을 때
        inputSearchBarTapped.bind { value in
            APIManager.shared.fetchCoinInfoAPI(api: .search(query: value), completionHandler: { data in
                self.outputCoinInfoAPI.value = data.coins
            })
        }
        
        inputViewTrigger.bind { value in
            APIManager.shared.fetchCoinPriceAPI(api: .market(query: value), completionHandler: { data in
                self.outputCoinPriceAPI.value = data
            })
        }
    }
}
