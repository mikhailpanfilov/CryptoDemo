//
//  CurrencyTests.swift
//  CryptoTests
//
//  Created by Mikhail Panfilov on 10.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class CurrencyTests: XCTestCase {

    var sut: Currency!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Currency(name: "Test cur", symbol: "TEST", priceUsd: 120)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testRealmModel() {
        // when
        let realmModel = sut.toRealmModel()
        // then
        XCTAssertEqual(realmModel.name, sut.name, "Realm model's data must be the same.")
        XCTAssertEqual(realmModel.symbol, sut.symbol, "Realm model's data must be the same.")
        XCTAssertEqual(realmModel.priceUsd, sut.priceUsd, "Realm model's data must be the same.")
    }
}
