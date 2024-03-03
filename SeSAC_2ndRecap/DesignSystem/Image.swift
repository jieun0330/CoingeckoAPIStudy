//
//  Image.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit

enum DesignSystemImage {
    case trend
    case trendInactive
    case search
    case searchInactive
    case user
    case userInactive
    case portfolio
    case portfolioInactive
    case star
    case starFill
}

extension DesignSystemImage {
    var image: UIImage {
        switch self {
        case .trend:
            return .tabTrend.withRenderingMode(.alwaysOriginal)
        case .trendInactive:
            return .tabTrendInactive
        case .search:
            return .tabSearch.withRenderingMode(.alwaysOriginal)
        case .searchInactive:
            return .tabSearch
        case .user:
            return .tabUser.withRenderingMode(.alwaysOriginal)
        case .userInactive:
            return .tabUser
        case .portfolio:
            return .tabPortfolio.withRenderingMode(.alwaysOriginal)
        case .portfolioInactive:
            return .tabPortfolio
        case .star:
            return .btnStar.withRenderingMode(.alwaysOriginal)
        case .starFill:
            return .btnStarFill.withRenderingMode(.alwaysOriginal)
        }
    }
}
