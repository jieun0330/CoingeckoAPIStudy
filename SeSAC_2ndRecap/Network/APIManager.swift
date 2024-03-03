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
    
    func fetchSearchAPI(api: CoinAPI, completionHandler: @escaping (Search) -> Void) {
        
        AF
            .request(api.endpoint)
            .responseDecodable(of: Search.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    func fetchMarketAPI(api: CoinAPI, completionHandler: @escaping ([Market]) -> Void) {
        
        AF
            .request(api.endpoint)
            .responseDecodable(of: [Market].self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    func fetchTrendingAPI(api: CoinAPI, completionHandler: @escaping (Trending) -> Void) {
        AF
            .request(api.endpoint)
            .responseDecodable(of: Trending.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}
