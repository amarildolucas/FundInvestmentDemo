//
//  FundPurchaseAuthenticationPresenter.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

protocol FundPurchaseAuthenticationPresenterDelegate: NSObjectProtocol {
  func didFinishAuthenticationWithSuccess()
  func didFinishAuthenticationWithError(_ message: String)
}

class FundPurchaseAuthenticationPresenter {
  weak var delegate: FundPurchaseAuthenticationPresenterDelegate?
  
  func authorizePayment(password: String) {
    if UserAccess.authentication == password {
      delegate?.didFinishAuthenticationWithSuccess()
    } else {
      delegate?.didFinishAuthenticationWithError("Credencias erradas: não foi possível autorizar o pagamento.")
    }
  }
}
