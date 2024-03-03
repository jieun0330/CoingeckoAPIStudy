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
    
    func fetchCoinInfoAPI(api: CoinAPI, completionHandler: @escaping (SearchAPI) -> Void) {
        
        AF
            .request(api.endpoint)
            .responseDecodable(of: SearchAPI.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    func fetchCoinPriceAPI(api: CoinAPI, completionHandler: @escaping ([Price]) -> Void) {
        
        AF
            .request(api.endpoint)
            .responseDecodable(of: [Price].self) { response in
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
