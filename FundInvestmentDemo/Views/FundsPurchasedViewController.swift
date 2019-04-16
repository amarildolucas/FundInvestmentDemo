//
//  FundsPurchasedViewController.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit
import RealmSwift

class FundsPurchasedViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  lazy var indicatorActivityView: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.center = self.view.center
    indicator.tintColor = UIColor(red: 34/255, green: 156/255, blue: 160/255, alpha: 1.0)
    indicator.style = .whiteLarge
    
    return indicator
  }()
  
  lazy var refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    return control
  }()
  
  private let fundsPurchasedPresenter = FundsPurchasedPresenter()
  var funds: Results<FundPurchase> = try! Realm().objects(FundPurchase.self) {
    didSet {
      collectionView.reloadData()
      collectionView.refreshControl?.endRefreshing()
    }
  }
}

// MARK: - FundsPurchasedPresenterDelegate
extension FundsPurchasedViewController: FundsPurchasedPresenterDelegate {
  func didStartLoading() {
    collectionView.isHidden = true
    
    indicatorActivityView.isHidden = false
    indicatorActivityView.startAnimating()
  }
  
  func didFinishLoading() {
    indicatorActivityView.isHidden = true
    indicatorActivityView.stopAnimating()
  }
  
  func didShowEmptyPurchasedFunds() {
    collectionView.isHidden = true
    
    guard let label = collectionView.backgroundView as? UILabel else {
      return
    }
    
    label.text = "Você ainda não possui nenhum fundo"
  }
  
  func didLoadFundsPurchased(_ funds: Results<FundPurchase>) {
    collectionView.isHidden = false
    self.funds = funds
  }
  
  func didFinishWithError(_ message: String) {
    guard let label = collectionView.backgroundView as? UILabel else {
      return
    }
    
    label.text = message
  }
}

// MARK: - UIViewController lifecycle
extension FundsPurchasedViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(indicatorActivityView)
    configureCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    fundsPurchasedPresenter.delegate = self
    fundsPurchasedPresenter.getFundsPurchased()
  }
}

// MARK: - FundsPurchasedViewController custom methods
extension FundsPurchasedViewController {
  func configureCollectionView() {
    collectionView.isHidden = true
    collectionView.refreshControl = refreshControl
    collectionView.register(UINib(nibName: "FundListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FundListCollectionCell")
    collectionView.dataSource = self
  }
  
  @objc func didPullToRefresh() {
    fundsPurchasedPresenter.getFundsPurchased()
  }
}

// MARK: - UICollectionViewDataSource
extension FundsPurchasedViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return funds.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FundListCollectionCell", for: indexPath) as? FundListCollectionCell else {
      return UICollectionViewCell()
    }
    
    let fund = funds[indexPath.row]
    
    cell.simpleNameLabel.text = fund.simpleName
    cell.specificationFundRiskProfileNameLabel.text = fund.fundRiskProfileName
    
    if let amount = fund.minimumInitialApplicationAmount {
      cell.operability​MinimumInitialApplicationAmountLabel.text = amount.brlCurrency
    }
    
    return cell
  }
}
