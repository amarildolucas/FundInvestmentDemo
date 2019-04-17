//
//  FundsContainerPresenter.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 17/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation

protocol FundsContainerPresenterDelegate: NSObjectProtocol {
  func didLoad(_ segmentTitles: [String])
}

class FundsContainerPresenter {
  weak var delegate: FundsContainerPresenterDelegate?
  
  let segmentTitles = ["Lista de fundos", "Meus fundos"]
  
  func load() {
    delegate?.didLoad(segmentTitles)
  }
}

