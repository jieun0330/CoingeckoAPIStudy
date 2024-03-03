//
//  ViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/2/24.
//

import Foundation

final class ViewModel {
    
    // Trending 화면, Favorite 화면
    var inputViewTrigger = Observable("")
    // Search 화면
    var inputSearchBarTapped = Observable("")
    
    var outputCoinPriceAPI: Observable<PriceAPI> = Observable([])
    var outputCoinInfoAPI: Observable<[InfoAPI]> = Observable([])
    
    init() {
        inputViewTrigger.bind { value in
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
                self.outputCoinPriceAPI.value = data
            }, query: value)
        }
        
        // 검색했을 때
        inputSearchBarTapped.bind { value in
            APIManager.shared.fetchCoinInfoAPI(completionHandler: { data in
                self.outputCoinInfoAPI.value = data.coins
            }, query: value)
        }
    }
}
