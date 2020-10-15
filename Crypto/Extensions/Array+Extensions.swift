//
//  Array+Extensions.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 05.10.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import Foundation

extension Array {
    /// Safe extraction. Returns `nil` in no item in the array. 
    subscript (item index: UInt) -> Element? {
        return Int(index) < count ? self[Int(index)] : nil
    }
}
