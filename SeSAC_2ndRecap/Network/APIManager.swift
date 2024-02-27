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
    
    func fetchCoinAPI(completionHandler: @escaping (Search) -> Void) {
        let url = "https://api.coingecko.com/api/v3/search?query=bitcoin"
        
        AF.request(url).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                completionHandler(success)
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
