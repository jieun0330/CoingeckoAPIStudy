//
//  Color.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit

enum DesignSystemColor {
    case purple
    case red
    case pink
    case blue
    case sky
    case black
    case gray
    case indigo
    case lightGray
    case white
}

extension DesignSystemColor {
    var color: UIColor {
        
        switch self {
            
        case .purple:
            return .init(red: 145, green: 76, blue: 245)
        case .red:
            return .init(red: 240, green: 68, blue: 82)
        case .pink:
            return .init(red: 255, green: 234, blue: 237)
        case .blue:
            return .init(red: 50, green: 130, blue: 248)
        case .sky:
            return .init(red: 229, green: 240, blue: 255)
        case .black:
            return .init(red: 0, green: 0, blue: 0)
        case .gray:
            return .init(red: 130, green: 130, blue: 130)
        case .indigo:
            return .init(red: 52, green: 61, blue: 76)
        case .lightGray:
            return .init(red: 243, green: 244, blue: 246)
        case .white:
            return .init(red: 255, green: 255, blue: 255)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
