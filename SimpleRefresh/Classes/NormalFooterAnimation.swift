//
//  Created by vsccw on 2018/6/26.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import UIKit

public class DefaultFooterAnimation: DefaultAnimation {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.isHidden = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageView.isHidden = false
    }
    
    public override func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool {
        if percent >= 1 {
            if scrollView.isDecelerating && !scrollView.isDragging {
                return true
            }
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = CGAffineTransform.identity
            }

        } else {
            UIView.animate(withDuration: 0.2) {
                self.imageView.transform = CGAffineTransform(rotationAngle: Constants.rotationAngle)
            }
        }
        return false
    }
}
