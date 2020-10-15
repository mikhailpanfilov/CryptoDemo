//
//  CoordinatorTests.swift
//  CryptoTests
//
//  Created by Mikhail Panfilov on 02.04.2020.
//  Copyright © 2020 Mikhail Panfilov. All rights reserved.
//

import XCTest
@testable import Crypto

class MockCoordinator: Coordinator {
    
    // MARK: Properties
    
    var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    // MARK: Public methods
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([MockViewController()], animated: false)
    }
}

class MockViewController: BaseViewController {
    
}

class CoordinatorTests: XCTestCase {
    
    var coordinator: MockCoordinator!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coordinator = MockCoordinator()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coordinator = nil
        super.tearDown()
    }
    
    func testStartMethod() {
        // when
        coordinator.start()
        // then
        XCTAssertFalse(coordinator.navigationController.viewControllers.isEmpty, "Coordinator's navigation controller must not be empty after `start` method call.")
    }
    
    func testChildCoordinatorsCollection() {
        let testCoordinator = MockCoordinator()
        // when
        coordinator.addChildCoordinator(testCoordinator)
        // then
        XCTAssertNotNil(coordinator.childCoordinators.filter({$0 === testCoordinator}).first, "Child coordinator must contain test coordinator in it.")
        // when
        coordinator.addChildCoordinator(testCoordinator)
        // then
        XCTAssertEqual(coordinator.childCoordinators.count, 1, "Test coordiantor must still exists in single form.")
        // when
        coordinator.removeChildCoordinator(testCoordinator)
        // then
        XCTAssertNil(coordinator.childCoordinators.filter({$0 === testCoordinator}).first, "Child coordinator must not contain test coordinator in it.")
    }
    
    func testPop() {
        // when
        // we added `MockViewController` as second item in collection due to possibility
        // performing `popViewController` under it at UINavigationController
        let mockViewController = MockViewController()
        coordinator.navigationController.setViewControllers([UIViewController(), mockViewController], animated: false)
        // then
        XCTAssertNotNil(coordinator.navigationController.viewControllers.filter({$0 === mockViewController}).first, "`MockViewController` must exists at navigationController.viewControllers collection after `start` call.")
        // when
        coordinator.popViewController(animated: false)
        // then
        XCTAssertNil(coordinator.navigationController.viewControllers.filter({$0 === mockViewController}).first, "`MockViewController` must not exists at navigationController.viewControllers collection after `pop` call.")
    }
    
    func testDismiss() {
        // given
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          XCTFail("Unable to get scene deleagte")
            return
        }
        
        // when
        sceneDelegate.window?.rootViewController = coordinator.navigationController
        sceneDelegate.window?.makeKeyAndVisible()
        
        coordinator.navigationController.setViewControllers([UIViewController()], animated: false)
        let mockViewController = MockViewController()
        coordinator.navigationController.present(mockViewController, animated: false, completion: nil)
        // then
        XCTAssertTrue(coordinator.navigationController.presentedViewController === mockViewController, "PresentedViewController must be `MockViewController`")
        // when
        let promise = expectation(description: "Completion handler invoked")
        coordinator.dismissView(animated: false) {
            promise.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        // then
        XCTAssertNil(coordinator.navigationController.presentedViewController, "PresentedViewController must be nil")
    }
}
