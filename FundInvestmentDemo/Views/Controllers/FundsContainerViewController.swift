//
//  FundsContainerViewController.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class FundsContainerViewController: UIViewController {
  @IBOutlet weak var segmentedControlView: ALSegmentedControl!
  @IBOutlet weak var contentView: UIView!
  
  enum SegmentIndex: Int {
    case fundsList
    case fundsPurchased
  }
  
  var currentSegmentedViewController: UIViewController?
  
  lazy var fundsListViewController: FundsListViewController? = {
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "FundsListViewControllerSID") as? FundsListViewController
    return viewController
  }()
  
  lazy var fundsPurchasedViewController: FundsPurchasedViewController? = {
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "FundsPurchasedViewControllerSID") as? FundsPurchasedViewController
    return viewController
  }()
  
  // TODO: Should go to the presenter?
  let segmentItems = ["Lista de fundos", "Meus fundos"]
}

// MARK: - UIViewController lifecycle
extension FundsContainerViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    segmentedControlView.segmentItems = segmentItems
    segmentedControlView.didSelectSegment = { sender in
      self.indexDidChangeForSegmentedControl(sender)
    }
    segmentedControlView.segmentControl.selectedSegmentIndex = SegmentIndex.fundsList.rawValue
    
    displayCurrentSegment(SegmentIndex.fundsList.rawValue)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if let currentSegmentedViewController = currentSegmentedViewController {
      currentSegmentedViewController.viewWillDisappear(animated)
    }
  }
}

// MARK: - Custom methods
extension FundsContainerViewController {
  func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
    guard let segmentIndex = SegmentIndex(rawValue: index) else {
      return nil
    }
    
    var viewController: UIViewController?
    
    switch segmentIndex {
    case .fundsList:
      viewController = fundsListViewController
    case .fundsPurchased:
      viewController = fundsPurchasedViewController
    }
    
    return viewController
  }
  
  func displayCurrentSegment(_ index: Int) {
    if let viewController = viewControllerForSelectedSegmentIndex(index) {
      addChild(viewController)
      viewController.didMove(toParent: self)
      viewController.view.frame = contentView.bounds
      contentView.addSubview(viewController.view)
      currentSegmentedViewController = viewController
    }
  }
  
  @objc func indexDidChangeForSegmentedControl(_ sender: UISegmentedControl) {
    self.currentSegmentedViewController!.view.removeFromSuperview()
    self.currentSegmentedViewController!.removeFromParent()
    displayCurrentSegment(sender.selectedSegmentIndex)
  }
}
