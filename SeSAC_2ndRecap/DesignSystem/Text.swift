//
//  Text.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import Foundation

class DesignSystemText {
    
    static var shared = DesignSystemText()
    
    private init() { }
    
    private let priceFormatter = NumberFormatter()
    
    func priceCalculator(_ number: Double) -> String {
        priceFormatter.numberStyle = .decimal
        let result = priceFormatter.string(from: number as NSNumber)
        return result ?? "0"
    }
    
    func percentageCalculator(number: Double) -> String {
        
        let percentage = String(format: "%.2f", number)
        
        if number < 0 {
            return percentage
        } else {
            return "+\(percentage)"
        }
    }    
}
