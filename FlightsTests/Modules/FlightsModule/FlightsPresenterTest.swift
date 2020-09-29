//
//  FlightsPresenterTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FlightsPresenterTest: XCTestCase {
    
    var sut: FlightsPresenter!
    var mockFlightsInteractor: MockFlightsInteractor!
    var mockFlightsRouter: MockFlightsRouter!
    var mockFlightsVC: MockFlightsVC!

    override func setUpWithError() throws {
        sut = FlightsPresenter()
        mockFlightsInteractor = MockFlightsInteractor()
        mockFlightsRouter = MockFlightsRouter()
        mockFlightsVC = MockFlightsVC()
        sut.interactor = mockFlightsInteractor
        sut.router = mockFlightsRouter
        sut.view = mockFlightsVC
    }

    override func tearDownWithError() throws {
        sut = nil
        mockFlightsInteractor = nil
        mockFlightsVC = nil
        mockFlightsRouter = nil
    }

    func testFlightsPresenter_WhenMapRegionChange_ShouldCallInteractorAndViewMethods() {
        
        // Act
        sut.onMapRegionChange(longMin: 10.123132, latMin: 12.12312, longMax: 12.4449, latMax: 15.124)
        
        // Assert
        XCTAssertTrue(mockFlightsVC.isLoading)
        XCTAssertTrue(mockFlightsInteractor.isFetching)
    }
    
    func testFlightsPresenter_WhenOnFilterTapped_ShouldShowFilterModule() {
        // Act
        sut.onFilterTap()
        // Assert
        XCTAssertTrue(mockFlightsRouter.isFilterModuleShown)
    }
    
    func testFlightsPresenter_WhenOnGetStateAllSuccess_ShouldShowFlights() {
        // Act
        sut.onGetStateAllSuccess(states: [])
        // Assert
        XCTAssertFalse(mockFlightsVC.isLoading)
        XCTAssertEqual(mockFlightsVC.flights?.count, [].count)
    }
    
    func testFlightsPresenter_WhenOnGetStateAllFailure_ShouldShowAlert() {
        // Act
        sut.onGetStateAllFailure(error: APIError.invalidRequestURLString)
        // Assert
        XCTAssertFalse(mockFlightsVC.isLoading)
        XCTAssertTrue(mockFlightsRouter.isErrorAlertShown)
        XCTAssertEqual(mockFlightsRouter.errorMessage, APIError.invalidRequestURLString.errorDescription)
    }
    
    func testFlightsPresenter_WhenAutoFetchStart_ShouldShowLoading() {
        // Act
        sut.autoFetchStart()
        // Assert
        XCTAssertTrue(mockFlightsVC.isLoading)
    }
    
    func testFlightsPresenter_WhenCountriesFiltered_ShouldFilterFlights() {
        // Arrange
        let filter = "Turkey"
        // Act
        sut.filteredCountry(filter)
        // Assert
        XCTAssertTrue(mockFlightsInteractor.isFiltered)
        XCTAssertEqual(mockFlightsInteractor.filteredCountry, filter)
    }

}
