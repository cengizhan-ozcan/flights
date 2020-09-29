//
//  FlightsInteractor.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FlightsInteractorTest: XCTestCase {
    
    var sut: FlightsInteractor!
    var mockFlightsPresenter: MockFlightsPresenter!
    var mockFlightManager: MockFlightManager!

    override func setUpWithError() throws {
        sut = FlightsInteractor()
        mockFlightsPresenter = MockFlightsPresenter()
        mockFlightManager = MockFlightManager()
        sut.presenter = mockFlightsPresenter
        sut.manager = mockFlightManager
    }

    override func tearDownWithError() throws {
        sut = nil
        mockFlightsPresenter = nil
        mockFlightManager = nil
    }
    
    func testFlightsInteractor_WhenFetchFlightsCalled_ShouldReturnStatesInSuccess() {
        // Act
        sut.fetchFlights(longMin: 12.33, latMin: 12.33, longMax: 12.33, latMax: 12.33)
        // Assert
        XCTAssertEqual(mockFlightsPresenter.states?.count ?? 0, 0)
    }
    
    func testFlightsInteractor_WhenFetchFlightsCalled_ShouldReturnErrorInFailure() {
        // Act
        mockFlightManager.shouldHaveError = true
        sut.fetchFlights(longMin: 12.33, latMin: 12.33, longMax: 12.33, latMax: 12.33)
        // Assert
        XCTAssertNotNil(mockFlightsPresenter.error)
    }

    func testFlightsInteractor_WhenFetchFlightsCalled_ShouldStartTimer() {
        // Act
        sut.fetchFlights(longMin: 12.33, latMin: 12.33, longMax: 12.33, latMax: 12.33)
        // Assert
        XCTAssertTrue(sut.timer?.isValid ?? false)
    }
    
    func testFlightsInteractor_WhenFilterFlightsCalledWithValue_ReturnsFilteredData() {
        // Act
        sut.filterFlights(with: "Turkey")
        // Assert
        XCTAssertEqual(sut.countryFilter, "Turkey")
        XCTAssertEqual(mockFlightsPresenter.states?.count, sut.filteredStates.count)
        
    }
    
    func testFlightsInteractor_WhenFilterFlightsCalledWithoutValue_ReturnsFilteredData() {
        // Act
        sut.filterFlights(with: nil)
        // Assert
        XCTAssertEqual(sut.countryFilter, nil)
        XCTAssertEqual(mockFlightsPresenter.states?.count, sut.states.count)
        
    }

}
