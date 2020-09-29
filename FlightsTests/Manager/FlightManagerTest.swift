//
//  FlightManagerTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FlightManagerTest: XCTestCase {
    
    var sut: FlightManager!
    var service: MockService!
    
    override func setUp() {
        service = MockService()
        sut = FlightManager(service: service)
    }
    
    override func tearDown() {
        service = nil
        sut = nil
    }
    
    func testUserManager_WhenLoginRequestIsSuccessfull_ReturnsObject() {
        // Act
        sut.getAllStates(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693) { (result) in
            switch result {
            case .success(let obj):
                // Assert
                XCTAssertNotNil(obj)
                XCTAssertEqual(self.service.callTimes, 1)
            case .failure(_):
                XCTFail("I shouldn't send error")
            }
        }
    }
    
    func testUserManager_WhenLoginRequestIsFailed_ReturnsError() {
        // Arrange
        service.shouldReturnError = true
        service.error = .invalidResponseModel
        // Act
        sut.getAllStates(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693) { (result) in
            switch result {
            case .success(_):
                XCTFail("I shouldn't send object")
            case .failure(let error):
                // Assert
                XCTAssertEqual(error, self.service.error)
                XCTAssertEqual(self.service.callTimes, 1)
            }
        }
    }
    
}
