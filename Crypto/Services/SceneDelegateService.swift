//
//  SceneDelegateService.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 9/30/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

class SceneDelegateService {
    
    // MARK: Properties
    
    let window: UIWindow!
    var appCoordinator: AppCoordinator!
    
    // MARK: Initialization
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: Public methods
    
    func setupAppCoordinator() {
        window.rootViewController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: window.rootViewController as! UINavigationController)
        appCoordinator.start()
        window.makeKeyAndVisible()
    }
}
