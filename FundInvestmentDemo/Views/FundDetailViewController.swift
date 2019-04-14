//
//  FundDetailViewController.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class FundDetailViewController: UIViewController {
  @IBOutlet weak var strategyVideoThumbnailImageView: UIImageView!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var initialDateLabel: UILabel!
  @IBOutlet weak var fundManagerDescriptionLabel: UILabel!
  
  @IBAction func didTapBuyButton(_ sender: UIButton) {
  
  }
  
  private let fundDetailPresenter = FundDetailPresenter()
  var fundDetail: FundInvestment?
}

// MARK: - UIViewController lifecycle
extension FundDetailViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fundDetailPresenter.delegate = self
    
    if let fundDetail = fundDetail {
      fundDetailPresenter.getFundDetail(fundDetail)
    }
  }
}

// MARK: - FundDetailPresenterDelegate
extension FundDetailViewController: FundDetailPresenterDelegate {
  func didLoadFundDetail(_ fund: FundInvestment) {
    // strategyVideoThumbnailImageView.image = UIImage()
    
    fullNameLabel.text = fund.fullName
    initialDateLabel.text = fund.initialDate
    fundManagerDescriptionLabel.text = fund.fundManager?.description
  }
}

