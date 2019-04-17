//
//  UserAccess.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import Foundation
import KeychainAccess

// This class was only created to simulate the payment authorization. The data it's hard code and without input because it's wasn't a requirement.
class UserAccess {
  static let UA_EMAIL = "vmarildo@gmail.com"
  static let UA_PASSWORD = "password"
  static let BUNDLE_IDENTIFIER = "com.amarildo.FundInvestmentDemo"
  
  static let keychain = Keychain(service: BUNDLE_IDENTIFIER)
  
  static var authentication: String? {
    get {
      guard let password = try? keychain.get(UA_EMAIL) else {
        return nil
      }
      
      return password
    }
    
    set {
      do {
        try keychain.set(UA_PASSWORD, key: UA_EMAIL)
      } catch {
        self.authentication = nil
      }
    }
  }
  
  static func cleanAllKeys() {
    do {
      try keychain.remove(UA_EMAIL)
    } catch {
      authentication = nil
    }
  }
}
