//
//  CellEnum.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/2/24.
//

import Foundation

enum collectionViewCellName: Int, CaseIterable {
    case highPrice
    case lowPrice
    case ath
    case atl
    
    var cellName: String {
        switch self {
        case .highPrice:
            "고가"
        case .lowPrice:
            "저가"
        case .ath:
            "신고점"
        case .atl:
            "신저점"
        }
    }
}
