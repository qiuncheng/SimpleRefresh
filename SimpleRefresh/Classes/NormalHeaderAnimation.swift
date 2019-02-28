//
//  Created by vsccw on 2018/6/26.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import UIKit

public class NormalHeaderAnimation: NormalAnimation {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.isHidden = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func willStopRefresh(_ scrollView: UIScrollView) {
        super.willStopRefresh(scrollView)
        imageView.transform = .identity
    }
    
    public override func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool {
        if percent <= -1.0 {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.imageView.transform = CGAffineTransform(rotationAngle: Constants.rotationAngle)
            })
            if !scrollView.isDragging && scrollView.isDecelerating {
                return true
            }
        }
        else {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.imageView.transform = .identity
            })
        }
        return false
    }
}
