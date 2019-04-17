//
//  FundsListPresenter.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

protocol FundsListPresenterDelegate: NSObjectProtocol {
  func didStartLoading()
  func didFinishLoading()
  func didShowEmptyFunds()
  func didLoadFundsList(_ funds: [FundInvestment])
  func didFinishedWithError(_ message: String)
}

class FundsListPresenter {
  weak var delegate: FundsListPresenterDelegate?
  
  func getFundsList() {
    delegate?.didStartLoading()
    APIClient.getFundsList(completion: { [weak self] funds in
      self?.delegate?.didFinishLoading()
      if let funds = funds as? [FundInvestment] {
        if funds.count == 0 {
          self?.delegate?.didShowEmptyFunds()
        } else {
          self?.delegate?.didLoadFundsList(Array(funds.prefix(6)))
        }
      }
    }) { error, _ in
      self.delegate?.didFinishedWithError(error.localizedDescription)
    }
  }
}
