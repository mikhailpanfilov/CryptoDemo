//
//  ConvertPresenterTests.swift
//  ConvertPresenterTests
//
//  Created by Mikhail Panfilov on 01.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class ConvertPresenterTests: XCTestCase {
    
    var viewController: ConvertViewControllerMock!
    var presenter: ConvertPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = ConvertViewControllerMock()
        presenter = ConvertPresenter(view: viewController, cryptocurrency: Currency(name: "Test cur", symbol: "TEST", priceUsd: 120))
    }
    
    override func tearDownWithError() throws {
        viewController = nil
        presenter = nil
    }
    
    func testAmountConverting() {
        // given
        let amount = "1.5" // In crypto
        let toFiat = true
        // when
        presenter.convertPrice(amount, toFiat)
        // then
        XCTAssertEqual(presenter.convertedPrice, 180, "Converted amount is wrong")
    }
    
    func testMinimumAmountConverting() {
        // given
        let amount = "0.00007" // In crypto
        let toFiat = true
        // when
        presenter.convertPrice(amount, toFiat)
        // then
        XCTAssertEqual(presenter.convertedPrice, presenter.maxValue, "Converted amount shoun not be less than maxValue")
    }
    
    func testNegativeAmountConverting() {
        // given
        let amount = "-3" // In crypto
        let toFiat = true
        // when
        presenter.convertPrice(amount, toFiat)
        // then
        XCTAssertEqual(presenter.convertedPrice, presenter.maxValue, "Converted amount shoun not be less than maxValue")
    }
    
    func testWrongInputConverting() {
        // given
        let amount = "-dgawr"
        let toFiat = true
        // when
        presenter.convertPrice(amount, toFiat)
        // then
        XCTAssertEqual(presenter.convertedPrice, 0, "Converted amount is wrong")
    }
}

class ConvertViewControllerMock: ConvertInterface {
    func populateView(name: String, symbol: String) {
        
    }
    
    func populateConvertBlock(price: String, symbol: String, name: String) {
        
    }
    
    func populateResultBlock(result: String, symbol: String, name: String) {
        
    }
    
    func setConvertedPrice() {
        
    }
}
