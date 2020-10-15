//
//  ConvertConfigurator.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/3/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

class ConvertConfigurator {
    
    func viewController(output: ConvertOutput, currency: Currency) -> ConvertViewController {
        let viewController = ConvertViewController.from(storyboard: .main)
        let presenter = ConvertPresenter(view: viewController, cryptocurrency: currency)
        viewController.set(presenter)
        presenter.set(output)
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = viewController
        return viewController
    }
}
