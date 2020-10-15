//
//  UINavigationBar+Extensions.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 23.01.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import UIKit

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}
