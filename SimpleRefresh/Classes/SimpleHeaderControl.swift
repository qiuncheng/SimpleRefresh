//
//  Created by vsccw on 2018/6/13.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

public class SimpleHeaderControl: SimpleRefreshControl {
    
    internal var isStopAnimating = false
    
    public override init(frame: CGRect, animationView: SimpleAnimationView) {
        super.init(frame: frame, animationView: animationView)
        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        animationView.frame = bounds
        addSubview(animationView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func startRefresh(scrollView: UIScrollView) {
        guard !isRefreshing else { return }
        isRefreshing = true
        var insets = scrollView.smp.contentInsets
        insets.top += animationView.size
        let previewBounces = scrollView.bounces
        scrollView.bounces = false
        animationView.willStartRefresh(scrollView)
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: {
            scrollView.contentOffset.y = -insets.top
            scrollView.smp.contentInsets = insets
            scrollView.bounces = previewBounces
        }) { [weak self] (_) in
            scrollView.contentOffset.y = -insets.top
            scrollView.smp.contentInsets = insets
            scrollView.bounces = previewBounces
            self?.sendActions(for: .valueChanged)
            self?.isRefreshing = true
        }
    }
    
    override func stopRefresh(scrollView: UIScrollView) {
        guard isRefreshing && !isStopAnimating else { return }
        isStopAnimating = true
        var insets = scrollView.smp.contentInsets
        insets.top -= animationView.size
        let previewBounces = scrollView.bounces
        scrollView.bounces = false
        animationView.willStopRefresh(scrollView)
        UIView.animate(withDuration: 0.2, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: {
            scrollView.smp.contentInsets = insets
            scrollView.bounces = previewBounces
        }) { [weak self] (_) in
            scrollView.smp.contentInsets = insets
            scrollView.bounces = previewBounces
            self?.isRefreshing = false
            self?.isStopAnimating = false
        }
    }
    
    public override func contentOffsetDidChange(_ scrollView: UIScrollView) {
        guard !isRefreshing else {
            previewContentOffsetY = scrollView.contentOffset.y
            return
        }
        let currentOffsetY = scrollView.smp.contentInsets.top + previewContentOffsetY
        let offsetYDidChange = scrollView.contentOffset.y - previewContentOffsetY
        let percent: Float = Float(currentOffsetY / animationView.size)
        let shouldStart = animationView.shouldStartRefresh(scrollView, percent: percent, currentOffsetY: currentOffsetY, offsetYDidChange: offsetYDidChange)
        if shouldStart {
            startRefresh(scrollView: scrollView)
        }
        previewContentOffsetY = scrollView.contentOffset.y
    }
}
