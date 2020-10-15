//
//  Coordinator.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 10/1/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    
    func start()
}

extension Coordinator {
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    func dismissView(animated: Bool, completion: (() -> Void)? = nil) {
        navigationController.visibleViewController?.dismiss(animated: animated, completion: completion)
    }
}
