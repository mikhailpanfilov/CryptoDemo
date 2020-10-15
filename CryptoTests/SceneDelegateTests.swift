//
//  SceneDelegateTests.swift
//  SceneDelegateTests
//
//  Created by Mikhail Panfilov on 02.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class SceneDelegateTests: XCTestCase {

    var sut: SceneDelegateService!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SceneDelegateService(window: UIWindow(frame: .zero))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testAppCoordinatorSetup() {
        // when
        sut.setupAppCoordinator()
        // then
        XCTAssertNotNil(sut.window.rootViewController, "RootViewController is nil after setup.")
        XCTAssertTrue(sut.window.isKeyWindow, "Window is not key after setup.")
        XCTAssertNotNil(sut.appCoordinator, "AppCoordinator is nil after setup.")
    }
}
