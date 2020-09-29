//
//  MainServiceTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class MainServiceTest: XCTestCase {
    
    var sut: MainService!
    var codableHelper: MockCodableHelper!
    var apiRequest: MockAPIRequest!
    
    override func setUp() {
        super.setUp()
        codableHelper = MockCodableHelper()
        apiRequest = MockAPIRequest()
        sut = MainService(codableHelper: codableHelper, apiRequest: apiRequest)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        codableHelper = nil
        apiRequest = nil
    }
    
    func testMainService_WhenRequestSucceedWithoutReqObj_ReturnsSuccess() {
        // Act
        sut.send(api: .statesAll(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693)) { (result: Result<GenericResp, APIError>) in
            switch result {
            case .success(let resp):
                // Assert
                XCTAssertNotNil(resp)
                XCTAssertTrue(self.codableHelper.isDecodeFuncCalled)
                XCTAssertTrue(!self.codableHelper.isEncodeFuncCalled)
            case .failure(_):
                XCTFail("I shouldn't send error")
            }
        }
    }
    
    func testMainService_WhenRequestFailedWithInvalidRequestURLString_RetursError() {
        // Arrange
        apiRequest.shouldCompleteWithError = true
        apiRequest.error = APIError.invalidRequestURLString
        // Act
        sut.send(api: .statesAll(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693)) { (result: Result<GenericResp, APIError>) in
            switch result {
            case .success(_):
                XCTFail("I shouldn't send response object")
            case .failure(let error):
                // Assert
                XCTAssertEqual(error, APIError.invalidRequestURLString)
                XCTAssertFalse(self.codableHelper.isDecodeFuncCalled)
                XCTAssertFalse(self.codableHelper.isEncodeFuncCalled)
            }
        }
    }
    
    func testMainService_WhenRequestFailed_RetursError() {
        // Arrange
        apiRequest.shouldCompleteWithError = true
        apiRequest.error = APIError.failedRequest(description: "Request Fail")
        // Act
        sut.send(api: .statesAll(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693)) { (result: Result<GenericResp, APIError>) in
            switch result {
            case .success(_):
                XCTFail("I shouldn't send response object")
            case .failure(let error):
                // Assert
                XCTAssertEqual(error, APIError.failedRequest(description: "Request Fail"))
                XCTAssertFalse(self.codableHelper.isDecodeFuncCalled)
                XCTAssertFalse(self.codableHelper.isEncodeFuncCalled)
            }
        }
    }
    
    func testMainService_WhenDecodingFailure_ReturnsError() {
        // Arrange
        codableHelper.shouldReturnNil = true
        // Act
        sut.send(api: .statesAll(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693)) { (result: Result<GenericResp, APIError>) in
            switch result {
            case .success(_):
                XCTFail("I shouldn't send response object")
            case .failure(let error):
                // Assert
                XCTAssertEqual(error, APIError.invalidResponseModel)
                XCTAssertTrue(self.codableHelper.isDecodeFuncCalled)
                XCTAssertFalse(self.codableHelper.isEncodeFuncCalled)
            }
        }
    }

    // Test may be uncommented after using api which includes request body 
//    func testMainService_WhenEncodingFailure_ReturnsSuccess() {
//        // Arrange
//        codableHelper.shouldReturnNil = true
//        let mockRequest = MockCodable(test: 0.0)
//        // Act
//        sut.send(api: .statesAll(longMin: 27.344531648, latMin: 40.226013967, longMax: 30.7411966586, latMax: 41.6004635693)) { (result: Result<GenericResp, APIError>) in
//            switch result {
//            case .success(_):
//                XCTFail("I shouldn send error")
//            case .failure(let error):
//                // Assert
//                XCTAssertEqual(error, APIError.invalidResponseModel)
//                XCTAssertTrue(self.codableHelper.isEncodeFuncCalled)
//            }
//        }
//    }
    
    
}
