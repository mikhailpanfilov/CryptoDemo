//
//  PriceCellInterface.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/8/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation

struct PriceCellItem {
    let name: String
    let symbol: String
    let priceUsd: String
    var priceHistory: [String]?
}
