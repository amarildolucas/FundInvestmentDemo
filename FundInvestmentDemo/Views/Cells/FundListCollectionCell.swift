//
//  FundListCollectionCell.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class FundListCollectionCell: UICollectionViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var leftBorderView: UIView!
  @IBOutlet weak var simpleNameLabel: UILabel!
  @IBOutlet weak var operability​MinimumInitialApplicationAmountLabel: UILabel!
  @IBOutlet weak var specificationFundRiskProfileNameLabel: UILabel!
  
  static let fundListCollectionCellHeight: CGFloat = 150.0
}

// MARK: - UIColletionViewCell lifecycle
extension FundListCollectionCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    layoutView()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    simpleNameLabel.text = nil
    operability​MinimumInitialApplicationAmountLabel.text = nil
    specificationFundRiskProfileNameLabel.text = nil
  }
}

// MARK: - Custom methods
extension FundListCollectionCell {
  func layoutView() {
    leftBorderView.backgroundColor = UIColor.random
    
    layer.cornerRadius = 10.0
    layer.backgroundColor = UIColor.clear.cgColor
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2.0)
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 4.0
    
    containerView.layer.cornerRadius = 10.0
    containerView.layer.masksToBounds = true
  }
}
