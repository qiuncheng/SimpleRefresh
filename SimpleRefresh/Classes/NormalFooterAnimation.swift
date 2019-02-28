//
//  Created by vsccw on 2018/6/26.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

public class NormalFooterAnimation: NormalAnimation {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.isHidden = false
        imageView.image = nil
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func willStartRefresh(_ scrollView: UIScrollView) {
        super.willStartRefresh(scrollView)
        imageView.isHidden = true
    }
    
    public override func willStopRefresh(_ scrollView: UIScrollView) {
        super.willStopRefresh(scrollView)
        imageView.isHidden = false
    }
    
    public override func shouldStartRefresh(_ scrollView: UIScrollView, percent: Float, currentOffsetY: CGFloat, offsetYDidChange change: CGFloat) -> Bool {
        if percent >= 0.5 && (scrollView.isDragging || scrollView.isDecelerating) {
            return true
        }
        return false
    }
}
