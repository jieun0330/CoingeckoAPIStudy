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
    var outputToastMessage: ((String) -> Void)?
    var outputPrice = Observable("")
    var outputPriceTextColor = Observable(false)
    
    init() {
        
        // 검색했을 때
        inputSearchBarTapped.bind { value in
            APIManager.shared.fetchSearchAPI(api: .search(query: value),
                                             completionHandler: { data in
                self.outputSearchAPI.value = data.coins
            })
        }
        
        inputViewTrigger.bind { value in
            //            if value.count != 0 {
            self.callRequest(value: value)
            //            }
        }
        
        inputTopCoinTrigger.bind { _ in
            APIManager.shared.fetchTrendingAPI(api: .trending) { data in
                self.outputTrendingCoinAPI.value = data.coins
                self.outputTrendingNFTAPI.value = data.nfts
            }
        }
    }
    
    func callRequest(value: String) {
        APIManager.shared.fetchMarketAPI(api: .market(query: value),
                                         completionHandler: { data in
            self.outputMarketAPI.value = data
        })
    }
    
    func idList() {
        let realmList = repository.fetchAllItem()
        var idList = ""
        
        for list in realmList {
            idList.append(list.id + ",")
        }
        inputViewTrigger.value = idList
    }
    
    // SearchView
    func favoriteButtonClick(id: String) {
        let saveToRealm = CoinRealmModel(id: id)
        let realmDatas = repository.readItemName(id: id)
        
        if realmDatas.contains(where: { data in
            repository.deleteItem(item: data)
            return true
        }) {
            outputToastMessage?("즐겨찾기에서 삭제되었습니다")
        } else {
            if repository.fetchAllItem().count >= 10 {
                outputToastMessage?("즐겨찾기는 최대 10개까지 가능합니다")
            } else {
                repository.createFavoriteItem(saveToRealm)
                outputToastMessage?("즐겨찾기에 추가되었습니다")
            }
        }
    }
    
    // ChartView
    func collectionViewCellPrice(indexPath: Int, data: Market) {
        var price: Double
        var textColor: Bool?
        
        switch indexPath {
        case 0:
            price = data.high24H
            textColor = true
        case 1:
            price = data.low24H
            textColor = false
        case 2:
            price = data.ath // 신고점
            textColor = true
        case 3:
            price = data.atl // 신저점
            textColor = false
            
        default:
            price = 0
            textColor = false
        }
        let calculatedPrice = DesignSystemText.shared.priceCalculator(price)
        
        outputPrice.value = calculatedPrice
        outputPriceTextColor.value = textColor!
    }
    
    // FavoriteView
    func priceTextColor(indexPath: Int) {
        if outputMarketAPI.value[indexPath].priceChangePercentage24H < 0 {
            outputPriceTextColor.value = false
        } else {
            outputPriceTextColor.value = true
        }
    }
}
