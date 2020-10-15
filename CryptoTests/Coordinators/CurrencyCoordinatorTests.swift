//
//  CurrencyCoordinatorTests.swift
//  CryptoTests
//
//  Created by Mikhail Panfilov on 02.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class CurrencyCoordinatorTests: XCTestCase {

    var sut: CurrencyCoordinator!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = CurrencyCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testStartMethod() {
        // when
        sut.start()
        // then
        XCTAssertFalse(sut.navigationController.viewControllers.isEmpty, "Coordinator's navigation controller must not be empty after `start` method call.")
    }
    /*
    func testShowConvertScene() {
        // given
        let currency = Currency(name: "Test cur", symbol: "TEST", priceUsd: 120)
        // when
        sut.start()
        sut.showConvertScene(currency: currency)
        // then
        XCTAssertTrue(sut.navigationController.visibleViewController is ConvertViewController, "Visible viewcontroller must be `ConvertViewController`")
    }
    
    func testShowTransferConvertScene() {
        // when
        sut.start()
        sut.showTransferScene()
        // then
        XCTAssertTrue(sut.navigationController.topViewController is TransferViewController, "Visible viewcontroller must be `TransferViewController`")
    }
    
    func testShowSuccessTransferScene() {
        // when
        sut.start()
        sut.showSuccessTransferScene(formattedAmount: "120")
        // then
        XCTAssertTrue(sut.navigationController.topViewController is SuccessTransferViewController, "Visible viewcontroller must be `SuccessTransferViewController`")
    }
    */
}
