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
  @IBOutlet weak var indicatorActivityView: UIActivityIndicatorView!
  
  lazy var refreshControl: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    return control
  }()
  
  private let fundsListPresenter = FundsListPresenter()
  
  private var funds = [FundInvestment]() {
    didSet {
      collectionView.reloadData()
      collectionView.refreshControl?.endRefreshing()
    }
  }
}

// MARK: - FundsListPresenterDelegate
extension FundsListViewController: FundsListPresenterDelegate {
  func didStartLoading() {
    collectionView.isHidden = true
    
    indicatorActivityView.isHidden = false
    indicatorActivityView.startAnimating()
  }
  
  func didFinishLoading() {
    indicatorActivityView.isHidden = true
    indicatorActivityView.stopAnimating()
  }
  
  func didShowEmptyFunds() {
    collectionView.isHidden = true
    
    guard let label = collectionView.backgroundView as? UILabel else {
      return
    }
    
    label.text = "Sem fundos"
  }
  
  func didLoadFundsList(_ funds: [FundInvestment]) {
    collectionView.isHidden = false
    self.funds = funds
  }
  
  func didFinishedWithError(_ error: Error) {
    collectionView.isHidden = true
    
    guard let label = collectionView.backgroundView as? UILabel else {
      return
    }
    
    label.text = "Não foi possível carregar a sua lista de fundos"
  }
}

// MARK: - UIViewController lifecycle
extension FundsListViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    indicatorActivityView.isHidden = true
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
    collectionView.isHidden = true
    collectionView.refreshControl = refreshControl
    collectionView.register(UINib(nibName: FundListCollectionCell.nibName, bundle: nil), forCellWithReuseIdentifier: FundListCollectionCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  @objc func didPullToRefresh() {
    fundsListPresenter.getFundsList()
  }
}

// MARK: - UICollectionViewDataSource
extension FundsListViewController: UICollectionViewDataSource {
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
    cell.specificationFundRiskProfileNameLabel.text = fund.specification?.fundRiskProfile?.name
    
    if let amount = fund.operability?.minimumInitialApplicationAmount {
      cell.operability​MinimumInitialApplicationAmountLabel.text = amount.brlCurrency
    }
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension FundsListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    performSegue(withIdentifier: "FundDetailViewControllerSegue", sender: indexPath)
  }
}

extension FundsListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.size.width, height: FundListCollectionCell.fundListCollectionCellHeight)
  }
}
