//
//  Created by vsccw on 2018/1/10.
//  Copyright © 2018年 Tongzhuo. All rights reserved.
//

import Foundation

public final class Simple<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SimpleCompatible {
    associatedtype CompatibleType
    var smp: CompatibleType { get set }
}


public extension SimpleCompatible {
    public var smp: Simple<Self> {
        get { return Simple(self) }
        set { }
    }
}

extension UIScrollView: SimpleCompatible { }
