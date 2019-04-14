//
//  FundStrategyVideo.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import ObjectMapper
import Foundation

class FundStrategyVideo: Mappable {
  var thumbnail: String? // optional
  
  required init?(map: Map) {}
}

// MARK: - FundStrategyVideo extension
extension FundStrategyVideo {
  func mapping(map: Map) {
    thumbnail <- map["thumbnail"]
  }
}
