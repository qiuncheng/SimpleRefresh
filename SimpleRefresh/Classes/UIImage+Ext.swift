//
//  Created by vsccw on 2018/6/13.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class UIKit.UIImage

private class Nothing { }

extension UIImage {
    class func named(_ name: String) -> UIImage? {
        return UIImage(named: name, in: Bundle(for: Nothing.self), compatibleWith: nil)
    }
}
