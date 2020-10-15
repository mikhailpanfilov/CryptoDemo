//
//  CustomizableLabel.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/8/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var letterSpacing: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else { return 0 }
        }
    }
}
