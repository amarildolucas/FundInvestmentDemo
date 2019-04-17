//
//  APIClient.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

// Created this class as a simple helper for the basic api configuration.
struct APIClient {
  struct Resources {
    static let fundDetailFull = "/fund_detail_full.json"
  }
  
  enum APIEnvironment: String {
    case staging = "https://s3.amazonaws.com/orama-media/json"
  }
  
  static let baseUrl: APIEnvironment = .staging

  typealias ResponseCompletion = (Any) -> Void
  
  typealias ErrorHandler = (_ error: Error, _ statusCode: Int?) -> Void
}
