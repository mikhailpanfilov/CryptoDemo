//
//  AppCoordinator.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 9/30/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    // MARK: Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Public methods
    
    func start() {
        startCurrencyFlow()
    }
    
    // MARK: Flows
    
    private func startCurrencyFlow() {
        let coordinator = CurrencyCoordinator(navigationController: navigationController)
        coordinator.output = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

// MARK: Currency coordinator output

extension AppCoordinator: CurrencyCoordinatorOutput {
    
}
