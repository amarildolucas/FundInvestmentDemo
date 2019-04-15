//
//  ALTextFieldView.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 15/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class ALTextFieldView: UIView {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  var didTextFieldChange: ((_: ALTextFieldView) -> Void)?
  
  @IBAction func textFieldChanged(_ sender: UITextField) {
    didTextFieldChange?(self)
  }
  
  var title: String? {
    didSet {
      titleLabel.text = title
      titleLabel.textColor = UIColor(red: 167/255, green: 167/255, blue: 167/255, alpha: 1)
    }
  }
  
  var inputPlaceholder: String? {
    didSet {
      textField.placeholder = inputPlaceholder
    }
  }
  
  var messageError: String? {
    didSet {
      titleLabel.text = messageError
      titleLabel.textColor = UIColor(red: 252/255, green: 89/255, blue: 89/255, alpha: 1)
    }
  }
  
  private var contentView: UIView!
  private var bottomBorder = CALayer()
  
  // MARK: - UIView Lifecycle
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    loadNib()
  }
}

// MARK: - Custom methods
extension ALTextFieldView {
  func loadNib() {
    contentView = Bundle.main.loadNibNamed("ALTextFieldView", owner: self, options: nil)!.first as? UIView
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    addBottomBorder(width: 1.5, color: .black)
    
    addSubview(contentView)
  }
  
  private func addBottomBorder(width: CGFloat, color: UIColor) {
    bottomBorder.borderWidth = width
    bottomBorder.borderColor = color.cgColor
    bottomBorder.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width, height: bottomBorder.borderWidth)
    
    textField.layer.addSublayer(bottomBorder)
    textField.layer.masksToBounds = true
  }
}
