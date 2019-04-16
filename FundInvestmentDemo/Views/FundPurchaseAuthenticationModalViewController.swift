//
//  PurchaseAuthenticationModalViewController.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 15/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class FundPurchaseAuthenticationModalViewController: UIViewController {
  @IBOutlet weak var modalView: ALTextFieldSingleInputModalView!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
  @IBAction func didTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
    hidesKeyboard()
  }
  
  let fundPurchaseAuthenticationPresenter = FundPurchaseAuthenticationPresenter()
  var fundInvestment: FundInvestment?
}

// MARK
extension FundPurchaseAuthenticationModalViewController: FundPurchaseAuthenticationPresenterDelegate {
  func didFinishAuthenticationWithSuccess() {
    let fund = FundPurchase()
    fund.simpleName = fundInvestment?.simpleName
    fund.minimumInitialApplicationAmount = fundInvestment?.operability?.minimumInitialApplicationAmount
    fund.fundRiskProfileName = fundInvestment?.specification?.fundRiskProfile?.name
    
    fundPurchaseAuthenticationPresenter.purchase(fund: fund)
  }
  
  func didFinishAuthenticationWithError(_ message: String) {
    modalView.textFieldView.messageError = message
  }
  
  func didPurchaseFundWithSuccess(_ fund: FundPurchase) {
    dismiss(animated: true) {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  func didPurchaseFundWithError(_ message: String) {
    modalView.textFieldView.messageError = message
  }
}

// MARK: - UIViewController lifecycle
extension FundPurchaseAuthenticationModalViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutView()
    showsKeyBoard()
    
    fundPurchaseAuthenticationPresenter.delegate = self
  }
}

// MARK: - Custom methods
extension FundPurchaseAuthenticationModalViewController {
  private func layoutView() {
    modalView.layer.cornerRadius = 12
    modalView.textFieldView.title = "Informe sua senha para finalizar a compra"
    modalView.textFieldView.textField!.isSecureTextEntry = true
    modalView.textFieldView.inputPlaceholder = "••••••••••••"
    
    modalView.didTapCancelButton = { [weak self] _ in
      self?.dismiss(animated: true, completion: nil)
    }
    
    modalView.didTapConfirmButton = { [weak self] modalView in
      self?.fundPurchaseAuthenticationPresenter.authorizePayment(password: modalView.textFieldView.textField.text ?? "")
    }
  }
}

// MARK: - UIKeyBoard events
extension FundPurchaseAuthenticationModalViewController {
  func showsKeyBoard() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(notification: Notification) {
    let userInfo = notification.userInfo! as NSDictionary
    let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
    let keyboardRectangle = keyboardFrame.cgRectValue
    let keyboardHeight = keyboardRectangle.height
    
    bottomConstraint.constant = -keyboardHeight
    view.layoutIfNeeded()
  }
  
  @objc private func hidesKeyboard() {
    view.endEditing(true)
    bottomConstraint.constant = 0
    view.layoutIfNeeded()
  }
}
