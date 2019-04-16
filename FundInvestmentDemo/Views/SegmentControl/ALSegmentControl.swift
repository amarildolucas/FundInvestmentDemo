//
//  ALSegmentControl.swift
//  FundInvestmentDemo
//
//  Created by Amarildo Lucas on 16/04/2019.
//  Copyright © 2019 Amarildo. All rights reserved.
//

import UIKit

class ALSegmentedControl: UIView {
  let segmentControl: UISegmentedControl = {
    let control = UISegmentedControl()
    control.backgroundColor = .clear
    control.tintColor = .clear
    control.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                    NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    control.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                                    NSAttributedString.Key.foregroundColor: UIColor(red: 34/255, green: 156/255, blue: 160/255, alpha: 1.0)], for: .selected)
    control.translatesAutoresizingMaskIntoConstraints = false
    
    return control
  }()
  
  let bottomBar: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 34/255, green: 156/255, blue: 160/255, alpha: 1.0)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var bottomBarWidthAnchor: NSLayoutConstraint?
  
  var segmentItems: [String] = [] {
    didSet {
      guard segmentItems.count > 0 else {
        return
      }
      
      addSegmentItems()
      configureConstraints()
      configureBottomBarWidthAnchorConstraints()
    }
  }
  
  var didSelectSegment: ((_ control: UISegmentedControl) -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
}

// MARK: - Custom methods
extension ALSegmentedControl {
  func configure() {
    segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    addSubview(segmentControl)
    addSubview(bottomBar)
    addSegmentItems()
  }
  
  func addSegmentItems() {
    for (index, value) in segmentItems.enumerated() {
      segmentControl.insertSegment(withTitle: value, at: index, animated: true)
    }
  }
  
  @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    didSelectSegment?(sender)
    
    UIView.animate(withDuration: 0.3) {
      let originX = (self.segmentControl.frame.width / CGFloat(self.segmentItems.count)) * CGFloat(self.segmentControl.selectedSegmentIndex)
      self.bottomBar.frame.origin.x = originX
    }
  }
  
  func configureConstraints() {
    segmentControl.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    segmentControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    segmentControl.topAnchor.constraint(equalTo: topAnchor).isActive = true
    segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    bottomBar.heightAnchor.constraint(equalToConstant: 2).isActive = true
    bottomBar.leftAnchor.constraint(equalTo: segmentControl.leftAnchor).isActive = true
    bottomBarWidthAnchor = bottomBar.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentItems.count))
    bottomBarWidthAnchor?.isActive = true
  }
  
  func configureBottomBarWidthAnchorConstraints() {
    bottomBarWidthAnchor?.isActive = false
    bottomBarWidthAnchor = bottomBar.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentItems.count))
    bottomBarWidthAnchor?.isActive = true
  }
}
