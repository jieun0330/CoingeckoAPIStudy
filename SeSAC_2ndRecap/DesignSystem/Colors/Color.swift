//
//  Color.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit

public enum DesignSystemColor {
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
    var value: UIColor {
        switch self {
        case .purple:
            return UIColor.init(red: 145, green: 76, blue: 245, alpha: 1)
        case .red:
            return UIColor.init(red: 240, green: 68, blue: 82, alpha: 1)
        case .pink:
            return UIColor.init(red: 255, green: 234, blue: 237, alpha: 1)
        case .blue:
            return UIColor.init(red: 50, green: 130, blue: 248, alpha: 1)
        case .sky:
            return UIColor.init(red: 229, green: 240, blue: 255, alpha: 1)
        case .black:
            return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        case .gray:
            return UIColor.init(red: 130, green: 130, blue: 130, alpha: 1)
        case .indigo:
            return UIColor.init(red: 52, green: 61, blue: 76, alpha: 1)
        case .lightGray:
            return UIColor.init(red: 243, green: 244, blue: 246, alpha: 1)
        case .white:
            return UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
