//
//  AppDelegate.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Delete all database saved data everytime the the app is launched.
    resetAppData()

    UserAccess.authentication = "password"
      
    return true
  }
}

extension AppDelegate {
  func resetAppData() {
    do {
      let realm = try Realm()
      try realm.write {
        realm.deleteAll()
      }
    } catch let error {
      print(error.localizedDescription)
    }
  }
}
