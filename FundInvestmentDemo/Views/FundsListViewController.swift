//
//  ViewController.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 14/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class FundsListViewController: UIViewController {
  @IBOutlet var collectionView: UICollectionView!
  
  private let fundsListPresenter = FundsListPresenter()
  
  private var funds = [FundInvestment]() {
    didSet {
      collectionView.reloadData()
    }
  }
}

// MARK: - FundsListPresenterDelegate
extension FundsListViewController: FundsListPresenterDelegate {
  func didStartLoading() {
    
  }
  
  func didFinishLoading() {
    
  }
  
  func didShowEmptyFunds() {
    collectionView.isHidden = true
    // Show empty view
  }
  
  func didLoadFundsList(_ funds: [FundInvestment]) {
    collectionView.isHidden = false
    self.funds = funds
    print(self.funds)
  }
  
  func didFinishedWithError(_ error: Error) {
    // Show some error modal view
  }
}

// MARK: - UIViewController lifecycle
extension FundsListViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    fundsListPresenter.delegate = self
    fundsListPresenter.getFundsList()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "FundDetailViewControllerSegue" {
      if let viewController = segue.destination as? FundDetailViewController {
        if let indexPath = sender as? IndexPath {
          let fund = funds[indexPath.row]
          viewController.fundDetail = fund
        }
      }
    }
  }
}

// MARK: - FundsListViewController custom methods
extension FundsListViewController {
  func configureCollectionView() {
    collectionView.register(UINib(nibName: "FundListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FundListCollectionCell")
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}

// MARK: - UICollectionViewDataSource
extension FundsListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return funds.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FundListCollectionCell", for: indexPath) as? FundListCollectionCell else {
      return UICollectionViewCell()
    }
    
    let fund = funds[indexPath.row]
    
    cell.simpleNameLabel.text = fund.simpleName
    cell.operability​MinimumInitialApplicationAmountLabel.text = fund.operability?.minimumInitialApplicationAmount
    cell.specificationFundRiskProfileNameLabel.text = fund.specification?.fundRiskProfile?.name
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension FundsListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "FundDetailViewControllerSegue", sender: indexPath)
  }
}
