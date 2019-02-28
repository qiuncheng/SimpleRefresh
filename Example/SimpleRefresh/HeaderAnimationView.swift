//
//  HeaderAnimationView.swift
//  PullToRefresh
//
//  Created by vsccw on 2018/4/11.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import UIKit

class Proxy {
  private(set) weak var target: AnyObject?
  private let selector: Selector
  class var triggerSelector: Selector { return #selector(Proxy.displayLinkTrigger(displayLink:)) }
  
  init(target: AnyObject, selector: Selector) {
    self.target = target
    self.selector = selector
  }
  
  @objc private func displayLinkTrigger(displayLink: CADisplayLink) {
    _ = target?.perform(selector, with: displayLink)
  }
}

extension CADisplayLink {
  
  convenience init(target: Any) {
    self.init(target: target, selector: Proxy.triggerSelector)
  }
}

public class HeaderAnimationView: UIView {
  
  public var hidesWhenStopped = true
  
  private var displayLink: CADisplayLink?
  
  private let leftView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 112/255.0, green: 0, blue: 228.0/255.0, alpha: 1)
    view.frame.origin = CGPoint(x: 0, y: 0)
    view.frame.size = CGSize(width: 16, height: 16)
    view.layer.cornerRadius = 8
    view.layer.masksToBounds = true
    return view
  }()
  private let rightView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 1, green: 54/255.0, blue: 224.0/255.0, alpha: 1)
    view.frame.origin = CGPoint(x: 18, y: 0)
    view.frame.size = CGSize(width: 16, height: 16)
    view.layer.cornerRadius = 8
    view.layer.masksToBounds = true
    return view
  }()
  private let rightView2: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 1, green: 54/255.0, blue: 224.0/255.0, alpha: 1)
    view.frame.origin = CGPoint(x: 18, y: 0)
    view.frame.size = CGSize(width: 16, height: 16)
    view.layer.cornerRadius = 8
    view.layer.masksToBounds = true
    return view
  }()
  
  private let leftAnimation: CAAnimation = {
    let animation = CAKeyframeAnimation(keyPath: "position.x")
    animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
    animation.values = [0, 9, 18, 9, 0]
    animation.duration = 1
    animation.repeatCount = Float.greatestFiniteMagnitude
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    return animation
  }()
  private let rightAnimation: CAAnimation = {
    let animation = CAKeyframeAnimation(keyPath: "position.x")
    animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
    animation.values = [18, 9, 0, 9, 18]
    animation.duration = 1
    animation.repeatCount = Float.greatestFiniteMagnitude
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    return animation
  }()
  private let right2Animation: CAAnimationGroup = {
    let animation = CAKeyframeAnimation(keyPath: "position.x")
    animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
    animation.values = [18, 9, 0, 9, 18]
    
    let animation2 = CAKeyframeAnimation(keyPath: "opacity")
    animation2.keyTimes = [0, 0.499, 0.5, 1]
    animation2.values = [0, 0, 1, 1]
    
    let group = CAAnimationGroup()
    group.animations = [animation, animation2]
    group.duration = 1
    group.repeatCount = Float.greatestFiniteMagnitude
    group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    return group
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    isHidden = true
    layer.masksToBounds = false
    addSubview(rightView)
    addSubview(leftView)
    addSubview(rightView2)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  deinit {
    displayLink?.invalidate()
    displayLink = nil
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    leftView.frame.origin = .zero
    rightView.frame.origin = CGPoint(x: leftView.frame.maxX + 2, y: 0)
    rightView2.frame.origin = CGPoint(x: leftView.frame.maxX + 2, y: 0)
  }
  
  public func startAnimating() {
    isHidden = false
    
    leftView.layer.add(leftAnimation, forKey: "leftView.animation")
    rightView.layer.add(rightAnimation, forKey: "rightView.animation")
    rightView2.layer.add(right2Animation, forKey: "rightView2.animation")
    
    displayLink?.invalidate()
    displayLink = nil
    
    displayLink = CADisplayLink(target: Proxy(target: self, selector: #selector(checkDisplayLink)))
    displayLink?.frameInterval = 30
    displayLink?.add(to: RunLoop.current, forMode: .common)
  }
  
  public func stopAnimating() {
    if hidesWhenStopped {
      isHidden = true
    }
    leftView.layer.removeAnimation(forKey: "leftView.animation")
    rightView.layer.removeAnimation(forKey: "rightView.animation")
    rightView2.layer.removeAnimation(forKey: "rightView2.animation")
    displayLink?.invalidate()
    displayLink = nil
  }
  
  @objc private func checkDisplayLink() {
    if leftView.layer.animation(forKey: "leftView.animation") == nil {
      startAnimating()
    }
  }
}
