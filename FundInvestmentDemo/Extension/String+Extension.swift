//
//  String+Extension.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

// MARK: - Currency
extension String {
  var brlCurrency: String? {
    let double = (self as NSString).doubleValue
    let number = NSNumber(value: double)
    let formatter = NumberFormatter()
    
    formatter.locale = Locale(identifier: "pt_BR")
    formatter.currencySymbol = "R$"
    formatter.numberStyle = .currency
    
    return formatter.string(from: number)
  }
}
