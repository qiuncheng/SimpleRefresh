//
//  Created by vsccw on 2018/6/9.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIScrollView

public protocol SmpAnimationProxy {
    
    var size: CGFloat { get }
    
    func willStartRefresh(_ scrollView: UIScrollView)
    func willStopRefresh(_ scrollView: UIScrollView)
    func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool
}


public typealias SmpAnimationView = (UIView & SmpAnimationProxy)

public extension SmpAnimationProxy where Self: UIView {
    /// default is 50.0
    public var size: CGFloat { return 50 }
}
