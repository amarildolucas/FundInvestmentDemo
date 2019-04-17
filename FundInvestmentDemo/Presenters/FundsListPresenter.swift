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
  func didShowEmptyFunds(_ message: String)
  func didLoadFundsList(_ funds: [FundInvestment])
  func didFinishedWithError(_ message: String)
}

class FundsListPresenter {
  weak var delegate: FundsListPresenterDelegate?
  
  // Rather to add the APIClient as dependecy on init(), a choose to add only the right static methods as the APIClient will grow. So, avoid to instantiate to much data or maybe using services colud helping to separate the concerns.
  
  func getFundsList() {
    delegate?.didStartLoading()
    
    APIClient.getFundsList(completion: { [weak self] funds in
      self?.delegate?.didFinishLoading()
    
      if let funds = funds as? [FundInvestment] {
        if funds.count == 0 {
          self?.delegate?.didShowEmptyFunds("Sem fundos")
        } else {
          self?.delegate?.didLoadFundsList(Array(funds.prefix(6)))
        }
      }
    }) { error, _ in
      self.delegate?.didFinishedWithError(error.localizedDescription)
    }
  }
}
