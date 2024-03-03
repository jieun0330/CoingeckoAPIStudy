//
//  ViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/2/24.
//

import Foundation

final class ViewModel {
    
    let repository = RepositoryRealm()
    
    // Search 화면
    var inputSearchBarTapped = Observable("")
    // Trending 화면, Favorite 화면
    var inputViewTrigger = Observable("")
    var inputTopCoinTrigger: Observable<Void?> = Observable(nil)
    
    var outputSearchAPI: Observable<[SearchAPI]> = Observable([])
    var outputMarketAPI: Observable<PriceAPI> = Observable([])
    var outputTrendingCoinAPI: Observable<[Coin]> = Observable([])
    var outputTrendingNFTAPI: Observable<[Nft]> = Observable([])
    
    
    init() {
        // 검색했을 때
        inputSearchBarTapped.bind { value in

            APIManager.shared.fetchSearchAPI(api: .search(query: value), completionHandler: { data in
                self.outputSearchAPI.value = data.coins
            })
        }
        
        inputViewTrigger.bind { value in
            APIManager.shared.fetchMarketAPI(api: .market(query: value), completionHandler: { data in
                self.outputMarketAPI.value = data
            })
        }
        
        inputTopCoinTrigger.bind { _ in
            APIManager.shared.fetchTrendingAPI(api: .trending) { data in
                self.outputTrendingCoinAPI.value = data.coins
                self.outputTrendingNFTAPI.value = data.nfts
            }
        }
        
    }
    
    func idList() {
        let realmList = repository.fetchAllItem()
        
        var idList = ""
        
        for list in realmList {
            idList.append(list.id + ",")
        }
        inputViewTrigger.value = idList
    }
}
