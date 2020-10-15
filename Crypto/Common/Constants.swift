//
//  Constants.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 3/27/18.
//  Copyright © 2018 Mikhail Panfilov. All rights reserved.
//

import Foundation


struct APIParameterKey {
    static let name = "name"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case coinmarketcapApiKey = "X-CMC_PRO_API_KEY"
}

enum ContentType: String {
    case json = "application/json"
    case coinmarketcapApiKey = "db2ac98d-0a7c-43e4-95ce-6a17e8de710d"
}

struct Constants {
    static let baseURL = "https://api.coincap.io/v2/"
}
