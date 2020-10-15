//
//  ConvertPresenter.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/3/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

import Foundation

protocol ConvertOutput: class {
    func onFinishConvert()
}

class ConvertPresenter {
    
    // MARK: Properties
    
    private weak var view: ConvertInterface!
    private weak var output: ConvertOutput!
    private var cryptocurrency: Currency!
    var toFiat = true
    var maxValue: Float {
        return toFiat ? 0.01 : 0.001
    }
    var convertedPrice: Float = 0.0
    
    // MARK: Initializers
    
    required init(view: ConvertInterface, cryptocurrency: Currency) {
        self.view = view
        self.cryptocurrency = cryptocurrency
    }
    
    // MARK: Public methods
    
    func set(_ output: ConvertOutput) {
        self.output = output
    }
}

// MARK: ConvertPresentation

extension ConvertPresenter: ConvertPresentation {
    func populateView() {
        view.populateView(name: cryptocurrency.name, symbol: cryptocurrency.symbol)
    }
    
    func segmentedChangedValue(_ toFiatConvert: Bool, convertPrice: String, resultPrice: String) {
        view.populateConvertBlock(price: (resultPrice.isEmpty || resultPrice == "0") ? "" : resultPrice, symbol: toFiatConvert ? cryptocurrency.symbol : "USD", name: toFiatConvert ? cryptocurrency.name.uppercased() : "US DOLLAR")
        view.populateResultBlock(result: convertPrice.isEmpty ? "0" : convertPrice, symbol: toFiatConvert ? "USD" : cryptocurrency.symbol, name: toFiatConvert ? "US DOLLAR" : cryptocurrency.name.uppercased())
    }
    
    func convertPrice(_ price: String?, _ toFiatConvert: Bool) {
        guard let priceStr = price, !priceStr.isEmpty, priceStr.removeWhitespaces().isNumeric,
              let floatPrice = Float(priceStr), floatPrice != 0,
              let currencyPrice = Float(cryptocurrency.priceUsd) else { return setInitialPrice() }
        let convertedPrice = toFiatConvert ? floatPrice * currencyPrice : floatPrice / currencyPrice
        self.convertedPrice = max(maxValue, convertedPrice)
        view.setConvertedPrice()
    }
    
    private func setInitialPrice() {
        convertedPrice = 0
        view.setConvertedPrice()
    }
    
    func onDismissAction() {
        output.onFinishConvert()
    }
}
