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
            
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
                self.outputPriceAPI.value = data
            }, query: value)
        }
    }
}
