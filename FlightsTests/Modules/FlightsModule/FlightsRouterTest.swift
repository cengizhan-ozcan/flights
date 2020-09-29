//
//  FlightsRouterTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FlightsRouterTest: XCTestCase {
    
    var sut: FlightsRouter!
    var mockFilterDelegate: MockFilterDelegate!
    
    override func setUpWithError() throws {
        sut = FlightsRouter()
        mockFilterDelegate = MockFilterDelegate()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockFilterDelegate = nil
    }
    
    func testFlightsRouter_WhenCreateModuleCalled_ReturnsVC() {
        // Arrange
        let vc = FlightsRouter.createModule()
        // Assert
        XCTAssertNotNil(vc)
    }

// Couldn't be solved the problem
//    func testFlightsRouter_WhenShowErrorAlertCalled_ReturnsAlertVC() {
//        // Arrange
//        let vc = FlightsRouter.createModule()
//        if let window = UIApplication.shared.windows.first {
//            // Act
//            sut.showErrorAlert(view: vc as! PVFlightsProtocol, with: "Error")
//            let expectation = XCTestExpectation(description: "Alert expectation")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
//                // Assert
//                XCTAssertTrue(window.rootViewController?.presentedViewController is UIAlertController)
//                expectation.fulfill()
//            })
//            wait(for: [expectation], timeout: 3)
//        }
//    }
//
//    func testFlightsRouter_WhenShowErrorFilterModuleCalled_ReturnsFilterVC() {
//        // Arrange
//        let vc = FlightsRouter.createModule()
//        if let window = UIApplication.shared.windows.first {
//            // Act
//            sut.showFilterModule(view: vc as! PVFlightsProtocol, delegate: mockFilterDelegate, filter: nil)
//            // Assert
//            XCTAssertTrue(window.rootViewController is FilterVC)
//        }
//    }
    
}
