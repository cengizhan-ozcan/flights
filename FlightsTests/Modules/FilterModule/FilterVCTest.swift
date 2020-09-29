//
//  FilterVCTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FilterVCTest: XCTestCase {
    
    var sut: FilterVC!
    var mockFilterPresenter: MockFilterPresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Filter", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC
        mockFilterPresenter = MockFilterPresenter()
        sut.presenter = mockFilterPresenter
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockFilterPresenter = nil
    }
    
    func testFilterVC_WhenLoaded_TextFieldIsConnected() throws {
         _ = try XCTUnwrap(sut.filterTextField)
    }
    
    func testFilterVC_WhenCreated_HasFilterTextFieldContentTypeSet() throws {
        let filterTextField = try XCTUnwrap(sut.filterTextField)
        XCTAssertEqual(filterTextField.textContentType, UITextContentType.countryName)
    }
    
    func testFilterVC_WhenCreated_FilterTextFieldShouldBeEmptyIfInitialFilterEmpty() throws {
        let filterTextField = try XCTUnwrap(sut.filterTextField)
        XCTAssertNil(mockFilterPresenter.getInitialFilter())
        XCTAssertEqual(filterTextField.text, "")
    }
    
    func testFilterVC_WhenCreated_HasFilterButtonAndAction() throws {
        // Arrange
        let filterButton: UIButton = try XCTUnwrap(sut.filterButton)
        
        // Act
        let filterButtonActions = try XCTUnwrap(filterButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        // Assert
        XCTAssertEqual(filterButtonActions.count, 1)
        XCTAssertEqual(filterButtonActions.first, "filterButtonTapped:")
    }
    
    func testFilterVC_WhenCreated_HasClearButtonAndAction() throws {
        // Arrange
        let clearButton: UIButton = try XCTUnwrap(sut.clearButton)
        
        // Act
        let clearButtonActions = try XCTUnwrap(clearButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        // Assert
        XCTAssertEqual(clearButtonActions.count, 1)
        XCTAssertEqual(clearButtonActions.first, "clearButtonTapped:")
    }
    
    func testFilterVC_WhenCreated_HasBackgroundButtonAndAction() throws {
        // Arrange
        let backgroundButton: UIButton = try XCTUnwrap(sut.backgrounButton)
        
        // Act
        let backgroundButtonActions = try XCTUnwrap(backgroundButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        // Assert
        XCTAssertEqual(backgroundButtonActions.count, 1)
        XCTAssertEqual(backgroundButtonActions.first, "backgroundButtonTapped:")
    }
    
    func testFilterVC_WhenBackgroundButtonTapped_InvokesDismissProcess() {
        // Arrange
        let myExpectation = expectation(description: "Expected the dismiss() method to be called")
        // Act
        sut.backgrounButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            myExpectation.fulfill()
        })
        self.wait(for: [myExpectation], timeout: 2)
        XCTAssertTrue(self.mockFilterPresenter.isDismissCalled)
    }
    
    func testFilterVC_WhenCreated_HasDefaultKeyboardTypeSet() throws {
       let filterTextField = try XCTUnwrap(sut.filterTextField)
        XCTAssertEqual(filterTextField.keyboardType, UIKeyboardType.default)
    }
    
    func testFilterVC_WhenClearButtonTapped_InvokesOnFilterMethodWithNil() {
        // Arrange
        let myExpectation = expectation(description: "Expected the onFilter(with:) method to be called")
        // Act
        sut.clearButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            myExpectation.fulfill()
        })
        self.wait(for: [myExpectation], timeout: 2)
        XCTAssertTrue(self.mockFilterPresenter.isOnFilterCalled)
        XCTAssertNil(self.mockFilterPresenter.filter)
    }
    
    func testFilterVC_WhenFilterButtonTapped_InvokesOnFilterMethodWithValue() throws {
        // Arrange
        let myExpectation = expectation(description: "Expected the onFilter(with:) method to be called")
        let filterTextField = try XCTUnwrap(sut.filterTextField)
        filterTextField.text = "Test"
        // Act
        sut.filterButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            myExpectation.fulfill()
        })
        self.wait(for: [myExpectation], timeout: 2)
        XCTAssertTrue(self.mockFilterPresenter.isOnFilterCalled)
        XCTAssertNotNil(self.mockFilterPresenter.filter)
    }
    
    func testFilterVC_WhenFilterButtonTapped_InvokesOnFilterMethodWithoutValue() throws {
        // Arrange
        let myExpectation = expectation(description: "Expected the onFilter(with:) method to be called")
        let filterTextField = try XCTUnwrap(sut.filterTextField)
        filterTextField.text = ""
        // Act
        sut.filterButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            myExpectation.fulfill()
        })
        self.wait(for: [myExpectation], timeout: 2)
        XCTAssertTrue(self.mockFilterPresenter.isOnFilterCalled)
        XCTAssertEqual(self.mockFilterPresenter.filter, "")
    }
    
}
