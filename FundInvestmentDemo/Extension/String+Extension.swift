//
//  String+Extension.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

// MARK: - Date
extension String {
  var date: String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "pt_BR_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    let date = dateFormatter.date(from: self)
    let dateFormatterString = DateFormatter()
    dateFormatterString .dateFormat = "d'/'MM'/'yy"
    
    let string = dateFormatterString.string(from: date!)
    
    return string
  }
}
