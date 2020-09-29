//
//  FilterPresenterTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FilterPresenterTest: XCTestCase {
    
    var sut: FilterPresenter!
    var mockFilterInteractor: MockFilterInteractor!
    var mockFilterVC: MockFilterVC!
    var mockFilterRouter: MockFilterRouter!
    var mockDelegate: MockFilterDelegate!
    
    override func setUp() {
        super.setUp()
        sut = FilterPresenter()
        mockFilterInteractor = MockFilterInteractor()
        mockFilterVC = MockFilterVC()
        mockFilterRouter = MockFilterRouter()
        mockDelegate = MockFilterDelegate()
        sut.view = mockFilterVC
        sut.interactor = mockFilterInteractor
        sut.router = mockFilterRouter
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockFilterVC = nil
        mockFilterInteractor = nil
        mockFilterRouter = nil
        mockDelegate = nil
    }
    
    func testFilterPresenter_WhenDismissIsCalled_RouterShouldBeCalled() {
        // Act
        sut.dismiss()
        // Assert
        XCTAssertTrue(mockFilterRouter.isDismissCalled)
    }
    
    func testFilterPresenter_WhenOnFilterIsCalledWithFilter_RouterShouldBeCalled() {
        // Arrange
        let filter = "Turkey"
        // Act
        sut.onFilter(with: filter)
        // Assert
        XCTAssertTrue(mockFilterRouter.isDismissCalled)
    }
    
    func testFilterPresenter_WhenOnFilterIsCalledWithoutFilter_RouterShouldBeCalled() {
        // Act
        sut.onFilter(with: nil)
        // Assert
        XCTAssertTrue(mockFilterRouter.isDismissCalled)
    }
    
    func testFilterPresenter_WhenGetInitialFilterCalled_ShouldReturnInitialFilter() {
        // Arrange
        sut.filter = "Test"
        // Act
        let filter = sut.getInitialFilter()
        // Assert
        XCTAssertEqual(sut.filter, filter)
    }
    
    func testFilterPresenter_WhenOnFilterIsCalled_CountryShouldBeSame() {
        // Arrange
        let filter = "Turkey"
        // Act
        sut.onFilter(with: filter)
        // Assert
        XCTAssertEqual(mockDelegate.country, filter)
    }
}
