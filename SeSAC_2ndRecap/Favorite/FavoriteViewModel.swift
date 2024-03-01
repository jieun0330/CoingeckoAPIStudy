//
//  FavoriteViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import Foundation

class FavoriteViewModel {
    
    var inputViewDidLoadTrigger = Observable("")
    
    var outputPriceAPI: Observable<PriceAPI> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { value in
            //            print("value", value) // whitebit
                        
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
                self.outputPriceAPI.value = data
                print("data", data)
            }, query: value)
            
        }
    }
    
//    inputDidSelectRow.bind { value in
//        APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
////                print("data", data)
//            /*
//             [SeSAC_2ndRecap.Price(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 82049329, high24H: 84583677, low24H: 80891947, priceChangePercentage24H: -0.247, ath: 85032453, athDate: "2024-02-28T17:20:23.244Z", roi: nil, lastUpdated: "2024-03-01T00:29:00.164Z")]
//             */
//            self.outputCoinPriceData.value = data
//        }, query: value)
//    }
    
}
