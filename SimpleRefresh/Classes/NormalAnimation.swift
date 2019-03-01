//
//  Created by vsccw on 2018/6/9.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIView

open class NormalAnimation: SimpleAnimationView {
    
    open var refresherHeight: CGFloat { return 50.0 }
    
    public let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage.named("arrow-down.png")
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        imageView.isHidden = true
        return imageView
    }()
    
    public let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.hidesWhenStopped = true
        return activityIndicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(activityIndicatorView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        imageView.center = center
        activityIndicatorView.center = center
    }
    
    open func willStartRefresh(_ scrollView: UIScrollView) {
        activityIndicatorView.isHidden = false
        imageView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    open func willStopRefresh(_ scrollView: UIScrollView) {
        activityIndicatorView.stopAnimating()
        imageView.isHidden = false
    }
    
    open func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool {
        return false
    }
}
