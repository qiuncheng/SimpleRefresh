//
//  Created by vsccw on 2018/6/9.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIScrollView

public extension Simple where Base: UIScrollView {
    
    var contentInsets: UIEdgeInsets {
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

public extension Simple where Base: UIScrollView {
    
    func animationView(forType type: RefreshType) -> SmpAnimationView? {
        return refreshControl(forType: type)?.animationView
    }
    
    func refreshControl(forType type: RefreshType) -> SmpRefreshControl? {
        switch type {
        case .header:
            return base.viewWithTag(Constants.header) as? SmpHeaderControl
        case .footer:
            return base.viewWithTag(Constants.footer) as? SmpFooterControl
        }
    }
    
    func addRefresh(forType type: RefreshType, animationView: SmpAnimationView) {
        switch type {
        case .header:
            base.addRefreshHeader(animationView)
        case .footer:
            base.addRefreshFooter(animationView)
        }
    }
    
    func addRefresh(forType type: RefreshType, animationView: SmpAnimationView, target: Any?, action: Selector) {
        addRefresh(forType: type, animationView: animationView)
        let control = self.refreshControl(forType: type)
        control?.addTarget(target, action: action, for: .valueChanged)
    }
    
    func startRefresh(forType type: RefreshType) {
        let control = self.refreshControl(forType: type)
        control?.startRefresh(scrollView: base, trigger: true)
    }
    
    func startAnimation(forType type: RefreshType) {
        let control = self.refreshControl(forType: type)
        control?.startRefresh(scrollView: base, trigger: false)
    }
    
    func stopRefresh(forType type: RefreshType) {
        let control = self.refreshControl(forType: type)
        control?.stopRefresh(scrollView: base)
    }
    
    func removeRefresh(forType type: RefreshType) {
        switch type {
        case .header:
            base.removeRefreshHeader()
        case .footer:
            base.removeRefreshFooter()
        }
    }
}
