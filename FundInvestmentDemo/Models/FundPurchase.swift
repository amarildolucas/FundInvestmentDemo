//
//  FundPurchase.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation
import RealmSwift

class FundPurchase: Object {
  @objc dynamic var simpleName: String?
  @objc dynamic var minimumInitialApplicationAmount: String?
  @objc dynamic var fundRiskProfileName: String?
}
