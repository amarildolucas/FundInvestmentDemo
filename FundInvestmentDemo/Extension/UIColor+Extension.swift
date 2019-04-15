//
//  UIColor+Extension.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 15/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

extension UIColor {
  class var random: UIColor {
    let colors = [
      UIColor(red: 145/255, green: 237/255, blue: 110/255, alpha: 1.0),
      UIColor(red: 221/255, green: 243/255, blue: 1/255, alpha: 1.0),
      UIColor(red: 34/255, green: 156/255, blue: 160/255, alpha: 1.0)]
    return colors[Int.random(in: 0..<colors.count)]
  }
}
