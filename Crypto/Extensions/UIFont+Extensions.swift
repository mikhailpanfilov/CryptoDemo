//
//  UIFont+Extensions.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 11.10.2019.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import UIKit

extension UIFont {
    /// Main font family of the app is `Montserrat` now.
    static func mainFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .light: return UIFont(name: "Montserrat-Light", size: fontSize)!
        case .medium: return UIFont(name: "Montserrat-Medium", size: fontSize)!
        case .semibold: return UIFont(name: "Montserrat-SemiBold", size: fontSize)!
        case .bold: return UIFont(name: "Montserrat-Bold", size: fontSize)!
        default: return UIFont(name: "Montserrat-Regular", size: fontSize)!
        }
    }
}
