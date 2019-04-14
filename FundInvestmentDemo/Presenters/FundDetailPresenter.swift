//
//  FundDetailPresenter.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

protocol FundDetailPresenterDelegate: NSObjectProtocol {
  func didLoadFundDetail(_ fund: FundInvestment)
}

class FundDetailPresenter {
  weak var delegate: FundDetailPresenterDelegate?
  
  func getFundDetail(_ fund: FundInvestment) {
    delegate?.didLoadFundDetail(fund)
  }
}
