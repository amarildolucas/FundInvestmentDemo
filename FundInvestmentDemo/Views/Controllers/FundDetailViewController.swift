//
//  FundDetailViewController.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Kingfisher
import UIKit

class FundDetailViewController: UIViewController {
  @IBOutlet weak var strategyVideoThumbnailImageView: UIImageView!
  @IBOutlet weak var fullNameLabel: UILabel!
  @IBOutlet weak var initialDateLabel: UILabel!
  @IBOutlet weak var fundManagerDescriptionLabel: UILabel!
  
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FundPurchaseAuthenticationModalViewControllerSegue" {
      if let viewController = segue.destination as? FundPurchaseAuthenticationModalViewController {
        if let fund = fundDetail {
          viewController.fundInvestment = fund
          viewController.fundPurchaseAuthenticationModalViewControllerDelegate = self
        }
      }
    }
  }
}

// MARK: - FundDetailPresenterDelegate
extension FundDetailViewController: FundDetailPresenterDelegate {
  func didLoadFundDetail(_ fund: FundInvestment) {
    if let imageUrlString = fund.strategyVideo?.thumbnail {
      let imageUrl = URL(string: imageUrlString)
      strategyVideoThumbnailImageView.kf.setImage(with: imageUrl)
    }
    
    fullNameLabel.text = fund.fullName
    initialDateLabel.text = fund.initialDate
    fundManagerDescriptionLabel.text = fund.fundManager?.description
  }
}

// MARK: - FundPurchaseAuthenticationModalViewControllerDelegate
extension FundDetailViewController: FundPurchaseAuthenticationModalViewControllerDelegate {  
  func didDismissViewController() {
    navigationController?.popViewController(animated: true)
  }
}

