//
//  DateFormatter+.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import Foundation

extension DateFormatter {
    static var dashDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static var slashDateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    static func dashToSlash(dateString: String) -> String {
        if let date = dashDateFormatter.date(from: dateString) {
            let slashDateString = slashDateFormatter.string(from: date)
            return slashDateString
        }
        return "-"
    }
}
