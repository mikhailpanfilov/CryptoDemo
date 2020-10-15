//
//  HistoryRequest.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 30.09.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import Foundation

struct HistoryRequest {
    var id: String = ""
    let interval: HistoryInterval
    let start: Int64?
    let end: Int64?
    
    var query: [String: String] {
        var dict = [String: String]()
        dict["interval"] = interval.rawValue
        if let start = start, let end = end {
            dict["start"] = String(start)
            dict["end"] = String(end)
        }
        return dict
    }
}
