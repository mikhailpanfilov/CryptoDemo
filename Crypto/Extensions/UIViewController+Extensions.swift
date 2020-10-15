//
//  UIViewController+Extensions.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/1/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    private class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        return instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }
    class func from(storyboard: Storyboard) -> Self {
        return controllerInStoryboard(UIStoryboard(name: storyboard.rawValue, bundle: nil), identifier: identifier)
    }
    
    func keyboardWillShowNotification(completion: ((CGRect?) -> Void)? = nil) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { (notification) -> Void in
            let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            completion?(keyboardFrame)
        })
    }
}
