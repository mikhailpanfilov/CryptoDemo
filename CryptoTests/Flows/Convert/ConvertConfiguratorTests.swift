//
//  ConvertConfiguratorTests.swift
//  ConvertPresenterTests
//
//  Created by Mikhail Panfilov on 02.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class ConvertConfiguratorTests: XCTestCase {

    var sut: ConvertConfigurator!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ConvertConfigurator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // given
        let currency = Currency(name: "Test cur", symbol: "TEST", priceUsd: 120)
        // when
        let viewController = sut.viewController(output: self, currency: currency)
        // then
        XCTAssertNotNil(viewController.presenter, "Presenter should be coupled to viewController")
    }
}

extension ConvertConfiguratorTests: ConvertOutput {
    func onFinishConvert() {
        
    }
}
