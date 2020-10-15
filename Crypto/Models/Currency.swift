//
//  Currency.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/2/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import Foundation
import ObjectMapper

struct Currency: Mappable {
    
    // MARK: Properties
    
    private(set) var id: String = ""
    private(set) var name: String = ""
    private(set) var symbol: String = ""
    private(set) var priceUsd: String = ""
    
    // MARK: Initializing
    
    init?(map: Map) {
    }
    
    init(id: String, name: String, symbol: String, priceUsd: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.priceUsd = priceUsd
    }
    
    // MARK: Methods
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        symbol <- map["symbol"]
        priceUsd <- map["priceUsd"]
    }
    
    func toRealmModel() -> CurrencyRealm {
        let realmModel = CurrencyRealm()
        realmModel.id = id
        realmModel.name = name
        realmModel.symbol = symbol
        realmModel.priceUsd = priceUsd
        return realmModel
    }
}
