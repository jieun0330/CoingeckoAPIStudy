//
//  TrendingViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import Foundation

class TrendingViewModel {
    
    var repository = repositoryCRUD()
    
    var inputViewDidLoadTrigger = Observable("")
    var realmList: [CoinRealmModel] = []
    
    var outputCoinDetailInfoAPIResult: Observable<PriceAPI> = Observable([])
    
//    var outputCoinDetailInfo: Observable<[PriceAPI]> = Observable([])
    
    init() {
        
        inputViewDidLoadTrigger.bind { value in

//            self.realmList = self.repository.fetchAllItem()
////            
//            var idList = ""
////            
////            print("realmList", realmList)
////            
//            for list in self.realmList {
//                idList.append(list.id + ",")
//            }
////            
//            print("idList", idList)
            
            
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
                self.outputCoinDetailInfoAPIResult.value = data
                
                
                
            }, query: value)

        }
        
//        inputViewDidLoadTrigger.bind { <#[CoinRealmModel]#> in
//            APIManager.shared.fetchCoinPriceAPI(completionHandler: { <#PriceAPI#> in
//                <#code#>
//            }, query: <#T##String#>)
//        }
        
    }
    
}
