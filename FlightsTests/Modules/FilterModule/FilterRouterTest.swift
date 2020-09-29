//
//  FilterRouterTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FilterRouterTest: XCTestCase {
    
    var sut: FilterRouter!
    var mockFilterDelegate: MockFilterDelegate!
    var mockFilterVC: MockFilterVC!

    override func setUpWithError() throws {
        sut = FilterRouter()
        mockFilterDelegate = MockFilterDelegate()
        mockFilterVC = MockFilterVC()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockFilterDelegate = nil
        mockFilterVC = nil
    }

    func testFilterRouter_WhenCreateModuleCalled_ReturnsVC() {
        // Arrange
        let vc = FilterRouter.createModule(delegate: mockFilterDelegate, filter: "")
        // Assert
        XCTAssertNotNil(vc)
    }
    
    func testFilterRouter_WhenDismissCalled_ReturnsFlightsVC() {
        // Arrange
        let vc = FilterRouter.createModule(delegate: mockFilterDelegate, filter: "")
        if let window = UIApplication.shared.windows.first {
            // Act
            window.rootViewController?.present(vc, animated: false, completion: nil)
            sut.dismiss(view: vc as! PVFilterProtocol)
            // Assert
            XCTAssertTrue(window.rootViewController is FlightsVC)
        }
    }
}
