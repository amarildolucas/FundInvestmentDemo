//
//  FundPurchaseAuthenticationPresenter.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation
import RealmSwift

protocol FundPurchaseAuthenticationPresenterDelegate: NSObjectProtocol {
  func didFinishAuthenticationWithSuccess()
  func didFinishAuthenticationWithError(_ message: String)
  func didPurchaseFundWithSuccess(_ fund: FundPurchase)
  func didPurchaseFundWithError(_ message: String)
}

class FundPurchaseAuthenticationPresenter {
  weak var delegate: FundPurchaseAuthenticationPresenterDelegate?
  let real = try! Realm()
  
  func authorizePayment(password: String) {
    if UserAccess.authentication == password {
      delegate?.didFinishAuthenticationWithSuccess()
    } else {
      delegate?.didFinishAuthenticationWithError("Credencias erradas")
    }
  }
  
  func purchase(fund: FundPurchase) {
    do {
      try real.write {
        real.add(fund)
        delegate?.didPurchaseFundWithSuccess(fund)
      }
    } catch let error {
      delegate?.didPurchaseFundWithError(error.localizedDescription)
    }
  }
}
