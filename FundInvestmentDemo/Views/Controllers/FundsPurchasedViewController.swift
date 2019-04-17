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
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
      
      collectionView.refreshControl = refreshControl
      collectionView.register(UINib(nibName: FundListCollectionCell.nibName, bundle: nil), forCellWithReuseIdentifier: FundListCollectionCell.identifier)
      collectionView.dataSource = self
    }
  }
  @IBOutlet weak var indicatorActivityView: UIActivityIndicatorView!
  @IBOutlet weak var descriptionLabel: UILabel!
  
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
  
  func didShowEmptyPurchasedFunds(_ message: String) {
    collectionView.isHidden = true
    descriptionLabel.isHidden = false
    descriptionLabel.text = message
  }
  
  func didLoadFundsPurchased(_ funds: Results<FundPurchase>) {
    collectionView.isHidden = false
    descriptionLabel.isHidden = true
    self.funds = funds
  }
  
  func didFinishWithError(_ message: String) {
    collectionView.isHidden = true
    descriptionLabel.isHidden = false
    descriptionLabel.text = message
  }
}

// MARK: - UIViewController lifecycle
extension FundsPurchasedViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    fundsPurchasedPresenter.delegate = self
    fundsPurchasedPresenter.getFundsPurchased()
  }
}

// MARK: - FundsPurchasedViewController custom methods
extension FundsPurchasedViewController {
  @objc func didPullToRefresh() {
    fundsPurchasedPresenter.getFundsPurchased()
  }
}

// MARK: - UICollectionViewDataSource
extension FundsPurchasedViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return funds.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FundListCollectionCell.identifier, for: indexPath) as? FundListCollectionCell else {
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

// MARK: - UICollectionViewDelegateFlowLayout
extension FundsPurchasedViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.size.width, height: FundListCollectionCell.fundListCollectionCellHeight)
  }
}
