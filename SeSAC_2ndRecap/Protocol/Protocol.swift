//
//  Protocol.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import Foundation

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
