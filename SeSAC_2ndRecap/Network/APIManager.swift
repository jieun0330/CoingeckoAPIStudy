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
    
    func callRequest(query: String) {
        let url = "https://api.coingecko.com/api/v3/search?query=\(query)"
        
        AF.request(url).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
