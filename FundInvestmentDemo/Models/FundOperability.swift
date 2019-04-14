//
//  FundOperability.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import ObjectMapper
import Foundation

class FundOperability: Mappable {
  var minimumInitialApplicationAmount: Double?
  
  required init?(map: Map) {}
}

// MARK: - FundOperability extension
extension FundOperability {
  func mapping(map: Map) {
    minimumInitialApplicationAmount <- map["minimum_initial_application_amount"]
  }
}
