//
//  Date+Extensions.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 30.09.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
}
