//
//  UIScrollView+Ext.swift
//  SimpleRefresh
//
//  Created by vsccw on 2019/2/28.
//

import UIKit

extension UIScrollView {
    
    func addRefreshHeader(_ animationView: SimpleAnimationView?) {
        guard let animationView = animationView else { return }
        if let header = self.smp.header {
            header.removeFromSuperview()
        }
        layoutIfNeeded()
        let offsetY = -animationView.size
        let refreshControl: SimpleHeaderControl
        let frame = CGRect(x: 0, y: offsetY, width: self.frame.width, height: animationView.size)
        refreshControl = SimpleHeaderControl(frame: frame, animationView: animationView)
        refreshControl.autoresizingMask = [.flexibleWidth]
        refreshControl.tag = Constants.header
        addSubview(refreshControl)
    }
    
    func removeRefreshHeader() {
        guard let header = self.smp.header else { return }
        if header.isRefreshing {
            header.stopRefresh(scrollView: self)
            delay(0.21) {
                header.removeFromSuperview()
            }
        } else {
            header.removeFromSuperview()
        }
    }
    
    func addRefreshFooter(_ animationView: SimpleAnimationView?) {
        guard let animationView = animationView else { return }
        if let footer = self.smp.footer {
            footer.removeFromSuperview()
        }
        layoutIfNeeded()
        let offsetY = contentSize.height
        let refreshView = SimpleFooterControl(frame: CGRect(x: 0, y: offsetY, width: frame.width, height: animationView.size), animationView: animationView)
        refreshView.tag = Constants.footer
        refreshView.autoresizingMask = [.flexibleWidth]
        addSubview(refreshView)
    }
    
    func removeRefreshFooter() {
        guard let footer = viewWithTag(Constants.footer) as? SimpleFooterControl else { return }
        if footer.isRefreshing {
            footer.stopRefresh(scrollView: self)
            delay(0.21) {
                footer.resetScrollViewContentInset(scrollView: self)
                footer.removeFromSuperview()
            }
        } else {
            footer.resetScrollViewContentInset(scrollView: self)
            footer.removeFromSuperview()
        }
    }
}
