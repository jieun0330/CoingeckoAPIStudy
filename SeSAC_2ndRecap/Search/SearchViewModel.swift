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
    
    // 5. viewDidLoad때 CoinRealmModel 초기화를 해줘야해서
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputSearchBarTapped = Observable("")
    var inputFavoritesButtonTapped: Observable<Void?> = Observable(nil)
    var inputDidSelectRow = Observable("")
    
    var outputCoinInfoData: Observable<[InfoAPI]> = Observable([])
    var outputCoinPriceData: Observable<PriceAPI> = Observable([])
    
    // 10. 초기화를 어떻게 해줘야할지 몰라서 초기화를 안하고 ! 를 붙였다, 그러면 초기화가 안됐으니 값이 없어서 오류가 나겠지
    // 그래서 초기화 어떻게 해줄건데
    // 어떻게 해야할지 모르는데 어떠한 흐름으로 [CoinRealmModel]이 되는건데
    
    // https://cyndi0330.tistory.com/40
    // 프로퍼티 옵저버가 struct에서만 동작하는 이유를 못하다보니 적어봤는데 혹시 틀린 부분이 있으면 말씀 부탁드립니다~!
    
    // 구조체인 array로 바꿔준다
    
    // 이런식에서 [CoinRealmModel]로 바꾼 이유는
    // realm은 테이블에 저장되는 형식이니까 didSet이 되지않는다
    // 밑에서 bind 형식으로 didSet을 해줘야하는데
    // 그래서 배열 형식으로 바꾸면 didSet이 동작한다
    //    var outputList: Observable<Results<CoinRealmModel>>!
    
    // 빈 배열에 담아서 보여줄거니까
    var outputList: Observable<[CoinRealmModel]> = Observable([])
    
    init() {
        
        // 6. CoinRealmModel 초기화를 위해 만든거니까 CoinRealmModel을 fetch(?)할 수 있는 repository를 만든다
        
        inputViewDidLoadTrigger.bind { _ in
            let data = self.repository.fetchAllItem()
            self.outputList.value = data
            print("1")
        }
        
        // 검색했을 때
        inputSearchBarTapped.bind { string in
            APIManager.shared.fetchCoinAPI(completionHandler: { value in
                self.outputCoinInfoData.value = value.coins
            }, query: string)
            print("3")
        }
        
        inputDidSelectRow.bind { value in
            print("2", value)
            APIManager.shared.fetchCoinPriceAPI(completionHandler: { data in
                self.outputCoinPriceData.value = data
            }, query: value)
            
        }
    }
}
