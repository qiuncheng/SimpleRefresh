//
//  RefershView.swift
//  PullToRefresh
//
//  Created by vsccw on 2018/6/9.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIControl

public class SmpRefreshControl: UIControl {
    
    internal static var kvoContext = "SimplePullToRefreshKVOContext"
    public let animationView: SmpAnimationView
    
    public internal(set) var isRefreshing = false
    public internal(set) var previewContentOffsetY: CGFloat = 0
    
    public init(frame: CGRect, animationView: SmpAnimationView) {
        self.animationView = animationView
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = superview as? UIScrollView else { return }
        addScrollViewObserver()
    }
    
    public override func removeFromSuperview() {
        removeScrollViewObserver()
        super.removeFromSuperview()
    }
    
    internal func startRefresh(scrollView: UIScrollView, trigger: Bool) {
        
    }
    
    internal func stopRefresh(scrollView: UIScrollView) {
        
    }
    
    internal func contentOffsetDidChange(_ scrollView: UIScrollView) {
        
    }
    
    internal func contentSizeDidChange(_ scrollView: UIScrollView) {
        
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &SmpRefreshControl.kvoContext, let rawKeyPath = keyPath, let scrollView = object as? UIScrollView else {
            return
        }
        switch rawKeyPath {
        case Constants.contentSizeKeyPath:
            contentSizeDidChange(scrollView)
        case Constants.contentOffsetKeyPath:
            contentOffsetDidChange(scrollView)
        default:
            break
        }
    }
    
    private func addScrollViewObserver() {
        guard let superScrollView = superview as? UIScrollView else { return }
        superScrollView.addObserver(self, forKeyPath: Constants.contentSizeKeyPath, options: [.initial, .new], context: &SmpRefreshControl.kvoContext)
        superScrollView.addObserver(self, forKeyPath: Constants.contentOffsetKeyPath, options: [.new], context: &SmpRefreshControl.kvoContext)
    }
    
    private func removeScrollViewObserver() {
        guard let superScrollView = superview as? UIScrollView else { return }
        superScrollView.removeObserver(self, forKeyPath: Constants.contentSizeKeyPath, context: &SmpRefreshControl.kvoContext)
        superScrollView.removeObserver(self, forKeyPath: Constants.contentOffsetKeyPath, context: &SmpRefreshControl.kvoContext)
    }
}
