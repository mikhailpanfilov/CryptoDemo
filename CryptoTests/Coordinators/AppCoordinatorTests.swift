//
//  AppCoordinatorTests.swift
//  CryptoTests
//
//  Created by Mikhail Panfilov on 02.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class AppCoordinatorTests: XCTestCase {

    var sut: AppCoordinator!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = AppCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testStartMethod() {
        // when
        sut.start()
        // then
        XCTAssertFalse(sut.childCoordinators.isEmpty, "App coordinator must have child coordinator after start.")
        XCTAssertFalse(sut.navigationController.viewControllers.isEmpty, "Coordinator's navigation controller must not be empty after `start` method call.")
    }
}
