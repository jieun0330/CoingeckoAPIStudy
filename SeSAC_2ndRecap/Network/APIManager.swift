//
//  APIManager.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func fetchCoinInfoAPI(completionHandler: @escaping (SearchAPI) -> Void, query: String) {
        let url = "https://api.coingecko.com/api/v3/search?query=\(query)"
        
        AF
            .request(url)
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
    
    func fetchCoinPriceAPI(completionHandler: @escaping ([Price]) -> Void, query: String) {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&ids=\(query)"
        
        AF
            .request(url)
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
