//
//  FundSpecification.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import ObjectMapper
import Foundation

class FundSpecification: Mappable {
  var fundRiskProfile: FundRiskProfile?
  
  required init?(map: Map) {}
}

// MARK: - FundSpecification extension
extension FundSpecification {
  func mapping(map: Map) {
    fundRiskProfile <- map["fund_risk_profile"]
  }
}
