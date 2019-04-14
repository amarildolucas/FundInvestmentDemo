//
//  FundInvestment.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import ObjectMapper
import Foundation

class FundInvestment: Mappable {
  var simpleName: String?
  var fullName: String?
  var initialDate: String?
  
  var strategyVideo: FundStrategyVideo?
  var fundManager: FundManager?
  var operability: FundOperability?
  var specification: FundSpecification?
  
  required init?(map: Map) {}
}

// MARK: - FundInvestment extension
extension FundInvestment {
  func mapping(map: Map) {
    simpleName <- map["simple_name"]
    fullName <- map ["full_name"]
    initialDate <- map["initial_date"]
    strategyVideo <- map["strategy_video"]
    fundManager <- map["fund_manager"]
    operability <- map["operability"]
    specification <- map["specification"]
  }
}
