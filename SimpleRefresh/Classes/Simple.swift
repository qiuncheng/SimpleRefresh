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



internal struct Constants {
    internal static let header = 13579
    internal static let footer = 24680
    
    internal static let contentOffsetKeyPath = "contentOffset"
    internal static let contentSizeKeyPath = "contentSize"
    
    internal static let rotationAngle: CGFloat = 0.000001 - .pi
}
