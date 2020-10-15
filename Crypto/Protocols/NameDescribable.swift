//
//  NameDescribable.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/1/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation

/// A way to get a *typeName* or *Identifier*. A common case to use while initializing *NameTableViewCell.identifier*.
protocol NameDescribable { }
extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self))
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension NSObject: NameDescribable { }
