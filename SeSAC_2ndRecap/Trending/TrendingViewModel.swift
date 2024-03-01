//
//  TrendingViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import Foundation

class TrendingViewModel {
    
    var inputViewDidLoadTrigger: Observable<[CoinRealmModel]> = Observable([])
    
    var outputCoinDetailInfo: Observable<[PriceAPI]> = Observable([])
    
    init() {
        
//        inputViewDidLoadTrigger.bind { <#[CoinRealmModel]#> in
//            APIManager.shared.fetchCoinPriceAPI(completionHandler: { <#PriceAPI#> in
//                <#code#>
//            }, query: <#T##String#>)
//        }
        
    }
    
}
