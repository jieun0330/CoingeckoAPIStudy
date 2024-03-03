//
//  TransitionStyle.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/3/24.
//

import UIKit

enum TransitionStyle {
    case presentNavigation
    case push
}

extension UIViewController {
    func transition(style: TransitionStyle, vc: UIViewController) {
        
        switch style {
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
