//
//  BaseViewController.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/2/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("\(Date().debugDescription) _ Log: _ \(#function) in \(self)")
    }
    
    // MARK: Methods
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func addTapGestureRecognizerForKeyboardDissmiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}
