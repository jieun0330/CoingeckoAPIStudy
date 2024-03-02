//
//  Font.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit

public enum DesignSystemFont {
    case allMainTitle
    case allCoinName
    case allSymbolName
    case allPriceBold
    case allPrice
    case allPercentageBold
    case allPercentage
    case trendingSubtitle
    case trendingRankNum
}

extension DesignSystemFont {
    var font: UIFont {
        switch self {
        case .allMainTitle:
            return .boldSystemFont(ofSize: 30)
        case .allCoinName:
            return .boldSystemFont(ofSize: 15)
        case .allSymbolName:
            return .systemFont(ofSize: 10)
        case .allPriceBold:
            return .boldSystemFont(ofSize: 18)
        case .allPrice:
            return .boldSystemFont(ofSize: 17)
        case .allPercentageBold:
            return .boldSystemFont(ofSize: 15)
        case .allPercentage:
            return .systemFont(ofSize: 15)
        case .trendingSubtitle:
            return .boldSystemFont(ofSize: 17)
        case .trendingRankNum:
            return .boldSystemFont(ofSize: 17)
        }
    }
}
