//
//  AmazingHeader.swift
//  Example
//
//  Created by vsccw on 2018/6/26.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import UIKit
import SimpleRefresh

open class AmazingHeader: SmpAnimationView {

  public var size: CGFloat { return 70.0 }
  
  public let animationView: HeaderAnimationView = {
    let view = HeaderAnimationView(frame: CGRect(x: 0, y: 0, width: 26, height: 14))
    view.hidesWhenStopped = true
    return view
  }()
  
  public let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "下拉刷新"
    label.textColor = UIColor(red: 118/255.0, green: 125/255.0, blue: 141/255.0, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 12)
    label.sizeToFit()
    return label
  }()
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(animationView)
    addSubview(titleLabel)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    let centerX = Int(bounds.width * 0.5)
    let centerY = Int(bounds.height * 0.5)
    animationView.center = CGPoint(x: centerX, y: centerY)
    titleLabel.center = CGPoint(x: centerX, y: centerY)
  }
  
  public func willStartRefresh(_ scrollView: UIScrollView) {
    animationView.startAnimating()
    titleLabel.isHidden = true
  }
  
  public func willStopRefresh(_ scrollView: UIScrollView) {
    animationView.stopAnimating()
    titleLabel.isHidden = false
  }
  
  public func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool {
    if percent <= -1.0 {
      UIView.animate(withDuration: 0.1) { [weak self] in
        self?.titleLabel.text = "松手刷新"
        self?.titleLabel.sizeToFit()
      }
      if !scrollView.isDragging && scrollView.isDecelerating {
        return true
      }
    }
    else {
      UIView.animate(withDuration: 0.1) { [weak self] in
        self?.titleLabel.text = "下拉刷新"
        self?.titleLabel.sizeToFit()
      }
    }
    return false
  }
  
}
