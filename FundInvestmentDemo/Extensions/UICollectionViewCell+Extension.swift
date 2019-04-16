//
//  UITableViewCell+Extension.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
  class var identifier: String {
    return String(describing: self)
  }
  
  class var nibName: String {
    return String(describing: self)
  }
}
