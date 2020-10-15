//
//  CurrencyCoordinator.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 9/30/19.
//  Copyright © 2019 Mikhail Panfilov. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyCoordinatorOutput: class { }

class CurrencyCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    weak var output: CurrencyCoordinatorOutput?
    
    // MARK: Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Public methods
    
    func start() {
        showCurrencyScene()
    }
    
    // MARK: Scenes
    
    func showCurrencyScene() {
        navigationController.setViewControllers([CurrencyConfigurator().viewController(output: self)], animated: true)
    }
    
    private func showConvertScene(currency: Currency) {
        let viewController = ConvertConfigurator().viewController(output: self, currency: currency)
        navigationController.visibleViewController?.present(viewController, animated: true)
    }
}

// MARK: PriceList output

extension CurrencyCoordinator: CurrencyOutput {
    func onSelected(item: Currency) {
        showConvertScene(currency: item)
    }
}

// MARK: PriceList output

extension CurrencyCoordinator: ConvertOutput {
    func onFinishConvert() {
        navigationController.visibleViewController?.dismiss(animated: true)
    }
}
