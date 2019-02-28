//
//  Created by vsccw on 2018/6/26.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import class Foundation.DispatchQueue

internal func delay(_ interval: TimeInterval, completion: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        completion()
    }
}

