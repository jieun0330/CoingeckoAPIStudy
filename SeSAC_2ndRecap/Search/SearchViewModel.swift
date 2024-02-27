//
//  SearchViewModel.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation

class SearchViewModel {
    
    var inputSearchBarTapped = Observable("")

    var outputCoinData: Observable<[Coin]> = Observable([])
    
    init() {
        inputSearchBarTapped.bind { string in
            APIManager.shared.fetchCoinAPI(completionHandler: { value in
                self.outputCoinData.value = value.coins
            }, query: string)
        }
    }
}
