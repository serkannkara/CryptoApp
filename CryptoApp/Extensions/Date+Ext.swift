//
//  Date+Ext.swift
//  CryptoApp
//
//  Created by Serkan on 11.05.2022.
//

import Foundation


extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
