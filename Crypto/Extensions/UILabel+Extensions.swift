//
//  UILabel+Extensions.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 11.10.2019.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import UIKit

extension UILabel {
    func setAttributed(text: String, font: UIFont, letterSpacing: CGFloat = 0.0, lineSpacing: CGFloat? = nil, lineHeightMultiple: CGFloat? = nil, textAlignment: NSTextAlignment = .natural) {
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .font: font,
            .kern: letterSpacing
            ])
        
        var paragraphStyle: NSMutableParagraphStyle? = NSMutableParagraphStyle()
        if let lineSpacing = lineSpacing {
            if paragraphStyle == nil {
                paragraphStyle = NSMutableParagraphStyle()
            }
            paragraphStyle!.lineSpacing = lineSpacing
        }
        if let lineHeightMultiple = lineHeightMultiple, lineHeightMultiple > 0.0 {
            if paragraphStyle == nil {
                paragraphStyle = NSMutableParagraphStyle()
            }
            paragraphStyle!.lineHeightMultiple = lineHeightMultiple
        }
        if let paragraphStyle = paragraphStyle {
            paragraphStyle.alignment = textAlignment
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        }
        self.attributedText = attributedString
    }
}
