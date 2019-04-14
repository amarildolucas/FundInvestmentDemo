//
//  FundRiskProfile.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import ObjectMapper
import Foundation

class FundRiskProfile: Mappable {
  var name: String?
  
  required init?(map: Map) {}
}

// MARK: - FundRiskProfile extension
extension FundRiskProfile {
  func mapping(map: Map) {
    name <- map["name"]
  }
}
