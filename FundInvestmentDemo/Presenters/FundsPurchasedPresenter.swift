//
//  FundsPurchasedPresenter.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation
import RealmSwift

protocol FundsPurchasedPresenterDelegate: NSObjectProtocol {
  func didStartLoading()
  func didFinishLoading()
  func didShowEmptyPurchasedFunds()
  func didLoadFundsPurchased(_ funds: Results<FundPurchase>)
  func didFinishWithError(_ message: String)
}

class FundsPurchasedPresenter {
  weak var delegate: FundsPurchasedPresenterDelegate?
  
  func getFundsPurchased() {
    delegate?.didStartLoading()
 
    DispatchQueue.main.async {
      self.delegate?.didFinishLoading()
      
      do {
        let realm = try Realm()
        let funds = realm.objects(FundPurchase.self)
        
        if funds.count > 0 {
          self.delegate?.didLoadFundsPurchased(funds)
        } else {
          self.delegate?.didShowEmptyPurchasedFunds()
        }
      } catch let error {
        self.delegate?.didFinishWithError(error.localizedDescription)
      }
    }
  }
}
