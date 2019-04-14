//
//  APIClient+Requests.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation

extension APIClient {
  static func getFundsList(completion: @escaping ResponseCompletion, errorHandler: @escaping ErrorHandler) {
    Alamofire.request("\(baseUrl.rawValue)\(Resources.fundDetailFull)", method: .get, headers: nil).responseArray { (response: DataResponse<[FundInvestment]>) in
      switch response.result {
      case .success(let value):
        completion(value)
      case .failure(let error):
        errorHandler(error, response.response?.statusCode)
      }
    }
  }
}
