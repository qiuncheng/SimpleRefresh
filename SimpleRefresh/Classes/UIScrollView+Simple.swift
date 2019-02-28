//
//  Created by vsccw on 2018/6/9.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIScrollView

public extension Simple where Base: UIScrollView {
    public var contentInsets: UIEdgeInsets {
        get {
            if #available(iOS 11.0, *) {
                return base.adjustedContentInset
            } else {
                return base.contentInset
            }
        }
        
        set {
            var inset = newValue
            if #available(iOS 11.0, *) {
                inset.top -= (base.adjustedContentInset.top - base.contentInset.top)
                inset.bottom -= (base.adjustedContentInset.bottom - base.contentInset.bottom)
                inset.left -= (base.adjustedContentInset.left - base.contentInset.left)
                inset.right -= (base.adjustedContentInset.right - base.contentInset.right)
            }
            base.contentInset = inset
        }
    }
}

// MARK: - Header
public extension Simple where Base: UIScrollView {
    
    public var headerAnimationView: SimpleAnimationView? {
        get {
            let header = base.smp.header
            return header?.animationView
        }
        set {
            base.addRefreshHeader(newValue)
        }
    }
    
    public var header: SimpleHeaderControl? {
        return base.viewWithTag(Constants.header) as? SimpleHeaderControl
    }
    
    public func addHeader(_ animationView: SimpleAnimationView) {
        base.addRefreshHeader(animationView)
    }
    
    public func addHeader(_ animationView: SimpleAnimationView, target: Any?, action: Selector) {
        base.addRefreshHeader(animationView)
        self.header?.addTarget(self, action: action, for: .valueChanged)
    }
    
    public func addHeaderAction(target: Any?, action: Selector) {
        self.header?.addTarget(self, action: action, for: .valueChanged)
    }
    
    public func removeHeader() {
        base.removeRefreshHeader()
    }
    
    public func startHeaderRefresh() {
        self.header?.startRefresh(scrollView: base)
    }
    
    public func stopHeaderRefresh() {
        self.header?.stopRefresh(scrollView: base)
    }
}

// MARK: - Footer
extension Simple where Base: UIScrollView {
    
    public var footerAnimationView: SimpleAnimationView? {
        get {
            let footer = base.smp.footer
            return footer?.animationView
        }
        set {
            base.addRefreshFooter(newValue)
        }
    }
    
    public var footer: SimpleFooterControl? {
        return base.viewWithTag(Constants.footer) as? SimpleFooterControl
    }
    
    public func addFooter(_ animationView: SimpleAnimationView) {
        base.addRefreshFooter(animationView)
    }
    
    public func addFooter(_ animationView: SimpleAnimationView, target: Any?, action: Selector) {
        base.addRefreshFooter(animationView)
        self.footer?.addTarget(self, action: action, for: .valueChanged)
    }
    
    public func addFooterAction(target: Any?, action: Selector) {
        self.footer?.addTarget(self, action: action, for: .valueChanged)
    }
    
    public func removeFooter() {
        base.removeRefreshFooter()
    }
    
    public func startFooterRefresh() {
        footer?.startRefresh(scrollView: base)
    }
    
    public func stopFooterRefresh() {
        footer?.stopRefresh(scrollView: base)
    }
}
