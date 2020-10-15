//
//  ConvertContract.swift
//  Crypto
//
//  Created by Mikhail Panfilov on 12/3/17.
//  Copyright © 2017 Mikhail Panfilov. All rights reserved.
//

protocol ConvertInterface: class {
    func populateView(name: String, symbol: String)
    func populateConvertBlock(price: String, symbol: String, name: String)
    func populateResultBlock(result: String, symbol: String, name: String)
    func setConvertedPrice()
}

protocol ConvertPresentation: class {
    var convertedPrice: Float { get set }
    var maxValue: Float { get }
    var toFiat: Bool { get set }
    func populateView()
    func segmentedChangedValue(_ toFiatConvert: Bool, convertPrice: String, resultPrice: String)
    func convertPrice(_ price: String?, _ toFiatConvert: Bool)
    func onDismissAction()
}
