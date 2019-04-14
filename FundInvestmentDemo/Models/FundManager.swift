//
//  FundManager.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import ObjectMapper
import Foundation

class FundManager: Mappable {
  var description: String?
  
  required init?(map: Map) {}
}

// MARK: - FundManager extension
extension FundManager {
  func mapping(map: Map) {
    description <- map["description"]
  }
}
