//
//  CurrencyRealm.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 4/12/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation
import RealmSwift


class CurrencyRealm: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""
    @objc dynamic var priceUsd = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> Currency {
        return Currency(id: id, name: name, symbol: symbol, priceUsd: priceUsd)
    }
}
