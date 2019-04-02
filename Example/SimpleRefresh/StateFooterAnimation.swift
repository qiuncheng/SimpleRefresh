//
//  StateFooterAnimation.swift
//  SimpleRefresh_Example
//
//  Created by vsccw on 2019/3/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SimpleRefresh
import pop

class StateFooterAnimation: DefaultAnimation {
  
  private class var rotation: CGFloat { return 0.000001 - .pi }
  
  enum State {
    case none
    case normal
    case noMoreData
  }
  
  var state: State = .normal {
    didSet {
      switch state {
      case .normal:
        noMoreLabel.text = nil
        imageView.isHidden = false
      case .noMoreData:
        noMoreLabel.text = "无更多数据"
        imageView.isHidden = true
      case .none:
        noMoreLabel.text = nil
        imageView.isHidden = true
      }
    }
  }
  
  private let noMoreLabel: UILabel = {
    let label = UILabel()
    if #available(iOS 8.2, *) {
      label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    } else {
      label.font = UIFont.systemFont(ofSize: 15)
    }
    label.textColor = UIColor.darkGray
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    imageView.isHidden = false
    addSubview(noMoreLabel)
    
    let centerX = NSLayoutConstraint(item: noMoreLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
    let centerY = NSLayoutConstraint(item: noMoreLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
    NSLayoutConstraint.activate([centerY, centerX])
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    imageView.isHidden = false
  }
  
  func startNoMoreDataAnimation() {
    guard noMoreLabel.pop_animation(forKey: "text_color_animation") == nil else { return }
    let animation = POPBasicAnimation(propertyNamed: kPOPLabelTextColor)
    animation?.fromValue = UIColor.lightGray
    animation?.toValue = UIColor.darkGray
    animation?.duration = 1.5
    animation?.autoreverses = true
    animation?.repeatForever = true
    animation?.timingFunction = CAMediaTimingFunction(name: .easeIn)
    noMoreLabel.pop_add(animation, forKey: "text_color_animation")
  }
  
  func stopNoMoreDataAnimation() {
    noMoreLabel.pop_removeAnimation(forKey: "text_color_animation")
    noMoreLabel.textColor = UIColor.darkGray
  }
  
  override func willStartRefresh(_ scrollView: UIScrollView) {
    switch state {
    case .normal:
      super.willStartRefresh(scrollView)
    default:
      activityIndicatorView.isHidden = true
      imageView.isHidden = true
    }
  }
  
  override func willStopRefresh(_ scrollView: UIScrollView) {
    switch state {
    case .normal:
      super.willStopRefresh(scrollView)
    default:
      activityIndicatorView.isHidden = true
      imageView.isHidden = true
    }
  }
  
  public override func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool {
    switch state {
    case .normal:
      if percent >= 1 {
        if scrollView.isDecelerating && !scrollView.isDragging {
          return true
        }
        UIView.animate(withDuration: 0.2) {
          self.imageView.transform = .identity
        }
        
      } else {
        UIView.animate(withDuration: 0.2) {
          self.imageView.transform = CGAffineTransform(rotationAngle: StateFooterAnimation.rotation)
        }
      }
    case .noMoreData:
      if percent >= 1 {
        startNoMoreDataAnimation()
      } else {
        stopNoMoreDataAnimation()
      }
    case .none:
        break
    }
    return false
  }
}
