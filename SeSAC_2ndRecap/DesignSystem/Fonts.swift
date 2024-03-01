//
//  Font.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit

public enum DesignSystemFont {
    case allMain
    case trendingSubtitle
    case coinName
    case favoriteSymbol
    case price
    case priceBold
    case percentage
    case percentageBold
}

extension DesignSystemFont {
    var font: UIFont {
        switch self {
        case .allMain:
            return .boldSystemFont(ofSize: 30) // dd
        case .trendingSubtitle:
            return .boldSystemFont(ofSize: 17)
        case .coinName:
            return .boldSystemFont(ofSize: 15) // dd
        case .favoriteSymbol:
            return .systemFont(ofSize: 10) // dd
        case .price:
            return .boldSystemFont(ofSize: 18) // ㅇㅇ
        case .priceBold:
            return .boldSystemFont(ofSize: 17)
        case .percentage:
            return .systemFont(ofSize: 15) //dd
        case .percentageBold:
            return .boldSystemFont(ofSize: 17)
        }
    }
}
