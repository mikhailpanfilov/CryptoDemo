//
//  HistoryRealm.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 30.09.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import Foundation
import RealmSwift


class HistoryRealm: Object {
    @objc dynamic var id = ""
    dynamic var pricesUsd = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toModel() -> History {
        return History(id: id, pricesUsd: Array(pricesUsd))
    }
}
