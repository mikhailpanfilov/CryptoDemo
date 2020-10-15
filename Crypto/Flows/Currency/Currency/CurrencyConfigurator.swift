//
//  CurrencyConfigurator.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/2/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

class CurrencyConfigurator {
    
    func viewController(output: CurrencyOutput) -> CurrencyViewController {
        let viewController = CurrencyViewController.from(storyboard: .main)
        let presenter = CurrencyPresenter(view: viewController, currencyService: СurrencyService(serverService: CurrencyServerService(core: URLSessionService())))
        viewController.set(presenter)
        presenter.set(output)
        return viewController
    }
}

