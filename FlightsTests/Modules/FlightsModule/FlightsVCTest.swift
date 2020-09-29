//
//  FlightsVCTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FlightsVCTest: XCTestCase {
    
    var sut: FlightsVC!
    var mockFlightsPresenter: MockFlightsPresenter!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Flights", bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "FlightsVC") as? FlightsVC
        mockFlightsPresenter = MockFlightsPresenter()
        sut.presenter = mockFlightsPresenter
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockFlightsPresenter = nil
    }
    
    func testFlightsVC_WhenCreated_AllOutlesShouldBeLoaded() throws {
        let _ = try XCTUnwrap(sut.mapView)
        let _ = try XCTUnwrap(sut.headerView)
        let _ = try XCTUnwrap(sut.filterButton)
        let _ = try XCTUnwrap(sut.countryLabel)
        let _ = try XCTUnwrap(sut.loadingActivityIndicator)
    }
    
    func testFlightsVC_WhenCreated_HasFilterButtonAndAction() throws {
        // Arrange
        let filterButton: UIButton = try XCTUnwrap(sut.filterButton)
        
        // Act
        let filterButtonActions = try XCTUnwrap(filterButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        // Assert
        XCTAssertEqual(filterButtonActions.count, 1)
    }
    
    func testFlightsVC_WhenFilterButtonTapped_InvokesOnFilterMethod() {
        // Arrange
        sut.filterButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockFlightsPresenter.isFilterTapped)
    }
    
    func testFlightsVC_WhenRegionChanged_OnMapRegionChangeShouldBeCalled() {
        // Arrange
        sut.mapView(sut.mapView, regionDidChangeAnimated: true)
        // Assert
        XCTAssertTrue(mockFlightsPresenter.isMapRegionChangeCalled)
    }
    
    func testFlightsVC_WhenShowFlightsCalled_MapShouldProcess() {
        // Arrange
        let flightDM = FlightDM(icao24: "", callSign: "", countryOrigin: "", longitude: 12.123, latitude: 15.123, velocity: 10, trueTrack: 234)
        
        sut.showFlights([flightDM], filteredCountry: "Turkey")
        // Assert
        XCTAssertEqual(sut.countryLabel.text, "Turkey")
        XCTAssertEqual(sut.airplaneImages.count, 1)
        XCTAssertTrue(sut.mapView.annotations.count > 0)
    }
    
    func testFlightsVC_WhenSetLoadingCalled_LoadingIndicatorShouldProcess() {
        // Arrange
        sut.setLoading(isVisible: true)
        // Assert
        XCTAssertTrue(sut.loadingActivityIndicator.isAnimating)
        XCTAssertFalse(sut.loadingActivityIndicator.isHidden)
        // Arrange
        sut.setLoading(isVisible: false)
        // Assert
        XCTAssertFalse(sut.loadingActivityIndicator.isAnimating)
        XCTAssertTrue(sut.loadingActivityIndicator.isHidden)
    }
    
    
}
