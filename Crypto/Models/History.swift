//
//  History.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 30.09.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import Foundation
import ObjectMapper

struct History {
    
    // MARK: Properties
    
    private(set) var id: String = ""
    private(set) var pricesUsd: [String] = []
    
    // MARK: Initializing
    
    init(id: String, pricesUsd: [String]) {
        self.id = id
        self.pricesUsd = pricesUsd
    }
    
    // MARK: Methods
    
    func toRealmModel() -> HistoryRealm {
        let realmModel = HistoryRealm()
        realmModel.id = id
        realmModel.pricesUsd.append(objectsIn: pricesUsd)
        return realmModel
    }
}
