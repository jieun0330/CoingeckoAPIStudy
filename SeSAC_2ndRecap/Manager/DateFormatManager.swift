//
//  DateFormatterService.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 6/21/24.
//

import Foundation

final class DateFormatManager {
    
    static let shared = DateFormatManager()
    
    private init() { }
    
    private let dateFormatter = DateFormatter()
    private let krLocale = Locale(identifier: "ko_kr")
    
    func formattedDate(input: String, inputFormat: DateStyle = .input, outputFormat: DateStyle = .output) -> String? {
        let date = stringToDate(input, format: inputFormat)
        return dateToString(date, format: outputFormat)
    }
    
    func stringToDate(_ stringDate: String, format: DateStyle) -> Date? {
        dateFormatter.locale = krLocale
        dateFormatter.dateFormat = format.rawValue
        let result = dateFormatter.date(from: stringDate)
        return result
    }
    
    func dateToString(_ date: Date?, format: DateStyle) -> String? {
        dateFormatter.locale = krLocale
        dateFormatter.dateFormat = format.rawValue
        guard let date else { return nil }
        let result = dateFormatter.string(from: date)
        return result
    }
}

extension DateFormatManager {
    enum DateStyle: String {
        case input = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case output = "M/d HH:mm:ss 업데이트"
    }
}
