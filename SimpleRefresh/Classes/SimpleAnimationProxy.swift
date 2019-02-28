//
//  Created by vsccw on 2018/6/9.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIScrollView

public protocol SimpleAnimationProxy {
    
    /// defalut is 44
    var size: CGFloat { get }
    
    func willStartRefresh(_ scrollView: UIScrollView)
    func willStopRefresh(_ scrollView: UIScrollView)
    func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool
}


public typealias SimpleAnimationView = (UIView & SimpleAnimationProxy)

public extension SimpleAnimationProxy where Self: UIView {
    public var size: CGFloat { return 44.0 }
}
