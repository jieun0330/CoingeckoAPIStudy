//
//  SearchViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation

class SearchViewModel {
    
    let repository = CoinRepository()
    
    var inputSearchBarTapped = Observable("")
    var inputFavoritesButtonTapped: Observable<Void?> = Observable(nil)

    var outputCoinData: Observable<[Coin]> = Observable([])
    
    init() {
        inputSearchBarTapped.bind { string in
            APIManager.shared.fetchCoinAPI(completionHandler: { value in
                self.outputCoinData.value = value.coins
            }, query: string)
        }
        
//        inputFavoritesButtonTapped.bind { <#Void?#> in
//            repository.createItem(name: <#T##String#>)
//        }
        
    }
}
