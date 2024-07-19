//
//  APIManager.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation
import Alamofire

final class APIManager {
    
    private init() { }
    
    static let shared = APIManager()
    
    // 실시간 업데이트
    private var isUpdate = false
    
    func fetchSearchAPI(api: CoinAPI, completionHandler: @escaping (Search) -> Void) {
        
        AF
            .request(api.endpoint)
            .responseDecodable(of: Search.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(_):
                    print("failure")
                }
            }
    }
    
    func fetchMarketAPI(api: CoinAPI, completionHandler: @escaping ([Market]) -> Void) {
        
        AF
            .request(api.endpoint)
            .responseDecodable(of: [Market].self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                    print("market failure")
                }
            }
    }
    
    func fetchTrendingAPI(api: CoinAPI, interval: TimeInterval, completionHandler: @escaping (Trending) -> Void) {
        AF
            .request(api.endpoint)
            .responseDecodable(of: Trending.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                    print("trending failure")
                }
                
                if self.isUpdate {
                    DispatchQueue.global().asyncAfter(deadline: .now() + interval) { [weak self] in
                        self?.fetchTrendingAPI(api: api, interval: interval, completionHandler: completionHandler)
                    }
                }
            }
    }
    
    func startUpdate(api: CoinAPI, interval: TimeInterval, completionHanlder: @escaping (Trending) -> Void ) {
        isUpdate = true
        
        fetchTrendingAPI(api: api, interval: interval, completionHandler: completionHanlder)
    }
    
    func stopUpdate() {
        isUpdate = false
    }
}
