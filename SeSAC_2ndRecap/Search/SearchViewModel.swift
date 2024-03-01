//
//  SearchViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation
import RealmSwift

class SearchViewModel {
    
    let repository = CoinRepository()
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputSearchBarTapped = Observable("")
    var inputFavoritesButtonTapped: Observable<Void?> = Observable(nil)
    var inputDidSelectRow = Observable("")
    
    var outputCoinInfoData: Observable<[InfoAPI]> = Observable([])
    var outputCoinPriceData: Observable<PriceAPI> = Observable([])
    var outputList: Observable<[CoinRealmModel]> = Observable([])
    
    // https://cyndi0330.tistory.com/40
    // 프로퍼티 옵저버가 struct에서만 동작하는 이유를 못하다보니 적어봤는데 혹시 틀린 부분이 있으면 말씀 부탁드립니다~!
    
    init() {
        
//        inputViewDidLoadTrigger.bind { _ in
//            let data = self.repository.fetchAllItem()
//            self.outputList.value = data
//            print("data", data)
//        }
        
        // 검색했을 때
        inputSearchBarTapped.bind { string in
            APIManager.shared.fetchCoinAPI(completionHandler: { value in
                self.outputCoinInfoData.value = value.coins
            }, query: string)
        }
        
        inputDidSelectRow.bind { value in
//            print("value", value) // white-rhinoceros
            
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
//                print("data", data)
                /*
                 [SeSAC_2ndRecap.Price(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 82049329, high24H: 84583677, low24H: 80891947, priceChangePercentage24H: -0.247, ath: 85032453, athDate: "2024-02-28T17:20:23.244Z", roi: nil, lastUpdated: "2024-03-01T00:29:00.164Z")]
                 */
                self.outputCoinPriceData.value = data
            }, query: value)
        }
    }
}
