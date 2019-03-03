//
//  Created by vsccw on 2018/6/13.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import UIKit.UIControl

public class SimpleFooterControl: SimpleRefreshControl {
    
    private var hasSetContentInsetBottom = false
    
    public override init(frame: CGRect, animationView: SimpleAnimationView) {
        super.init(frame: frame, animationView: animationView)
        animationView.frame = bounds
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(animationView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetScrollViewContentInset(scrollView: UIScrollView) {
        guard hasSetContentInsetBottom else { return }
        var inset = scrollView.smp.contentInsets
        inset.bottom -= animationView.size
        scrollView.smp.contentInsets = inset
    }
    
    override func startRefresh(scrollView: UIScrollView, trigger: Bool) {
        guard !isRefreshing else { return }
        isRefreshing = true
        animationView.willStartRefresh(scrollView)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(650)) { [weak self] in
            guard self != nil else { return }
            if trigger {
                self?.sendActions(for: .valueChanged)
            }
        }
    }
    
    override func stopRefresh(scrollView: UIScrollView) {
        guard isRefreshing else { return }
        animationView.willStopRefresh(scrollView)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1)) {
            self.isRefreshing = false
            self.frame.origin.y = scrollView.contentSize.height
        }
    }
    
    public override func contentOffsetDidChange(_ scrollView: UIScrollView) {
        guard !isRefreshing else {
            previewContentOffsetY = scrollView.contentOffset.y
            return
        }
        let remainHeight: CGFloat
        if scrollView.contentSize.height > scrollView.frame.height {
            remainHeight = scrollView.contentOffset.y + scrollView.frame.height - scrollView.contentSize.height
                - (scrollView.contentInset.bottom - animationView.size)
            // FIXME: - 底部保留 `contentInset.bottom`
        } else {
            remainHeight = scrollView.contentOffset.y + scrollView.smp.contentInsets.top
        }
        let percent: Float = Float(remainHeight / animationView.size)
        let offsetYDidChange = scrollView.contentOffset.y - previewContentOffsetY
        let currentOffsetY = scrollView.smp.contentInsets.top + previewContentOffsetY
        let shouldStart = animationView.shouldStartRefresh(scrollView, percent: percent, currentOffsetY: currentOffsetY, offsetYDidChange: offsetYDidChange)
        if shouldStart {
            startRefresh(scrollView: scrollView, trigger: true)
        }
        previewContentOffsetY = scrollView.contentOffset.y
    }
    
    public override func contentSizeDidChange(_ scrollView: UIScrollView) {
        super.contentSizeDidChange(scrollView)
        guard !isRefreshing else { return }
        frame.origin.y = scrollView.contentSize.height
        if !hasSetContentInsetBottom {
            hasSetContentInsetBottom = true
            var inset = scrollView.smp.contentInsets
            inset.bottom += animationView.size
            scrollView.smp.contentInsets = inset
        }
    }
}
