//
//  String+Extension.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/3/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func removeWhitespaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    var numeric: String {
        return self.components(separatedBy: CharacterSet(charactersIn: ".0123456789").inverted).joined(separator: "")
    }
    
    var isNumeric: Bool {
        guard !self.isEmpty else { return false }
        let nums: Set<Character> = ["-", ",", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    /// Uses the number format corresponding to your Locale
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        return formatter
    }
    
    var comaFormatted: String {
        guard isNumeric else { return self }
        let textWithoutGroupingSeparator = self.replacingOccurrences(of: formatter.groupingSeparator, with: "")
        guard let doubleValue = Double(textWithoutGroupingSeparator), let formattedString = formatter.string(from: NSNumber(value: doubleValue)) else { return self }
        return formattedString
    }
    
    /// Removes `groupingSeparator` to return clear double.
    var comaUnformatted: String {
        let textWithoutGroupingSeparator = self.replacingOccurrences(of: formatter.groupingSeparator, with: "")
        return textWithoutGroupingSeparator
    }
}
