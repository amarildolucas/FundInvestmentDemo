//
//  FundListCollectionCell.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class FundListCollectionCell: UICollectionViewCell {
  @IBOutlet weak var simpleNameLabel: UILabel!
  @IBOutlet weak var operability​MinimumInitialApplicationAmountLabel: UILabel!
  @IBOutlet weak var specificationFundRiskProfileNameLabel: UILabel!
}

// MARK: - UIColletionViewCell lifecycle
extension FundListCollectionCell {
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
