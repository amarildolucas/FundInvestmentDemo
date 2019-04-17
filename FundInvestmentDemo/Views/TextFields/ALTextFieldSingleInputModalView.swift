//
//  ALTextSingleInputModalView.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 15/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class ALTextFieldSingleInputModalView: UIView {
  @IBOutlet var textFieldView: ALTextFieldView!
  @IBOutlet var confirmButton: UIButton!
  @IBOutlet var cancelButton: UIButton!
  
  var didTapCancelButton: ((_ view: ALTextFieldSingleInputModalView) -> Void)?
  var didTapConfirmButton: ((_ view: ALTextFieldSingleInputModalView) -> Void)?
  
  @IBAction func cancelButtonTapped(_ sender: UIButton) {
    didTapCancelButton?(self)
  }
  
  @IBAction func confirmButtonTapped(_ sender: UIButton) {
    didTapConfirmButton?(self)
  }
  
  private var contentView: UIView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    loadNib()
  }
}

// MARK: - Custom methods
extension ALTextFieldSingleInputModalView {
  private func loadNib() {
    contentView = Bundle.main.loadNibNamed("ALTextFieldSingleInputModalView", owner: self, options: nil)!.first as? UIView
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    configureSubviews()
    addSubview(contentView)
  }
  
  private func configureSubviews() {
    cancelButton.layer.cornerRadius = 4
    confirmButton.layer.cornerRadius = 4
  }
}
