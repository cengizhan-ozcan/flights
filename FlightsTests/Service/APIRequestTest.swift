//
//  APIRequestTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class APIRequestTest: XCTestCase {
    
    var sut: APIRequest!
    var http: Http!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        http = Http(path: "testpath", method: .get, body: nil)
        sut = APIRequest(session: urlSession)
        sut.http = http
    }

    override func tearDown() {
        http = nil
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testAPIRequest_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let jsonString = "{\"result\": {\"retcode\": \"0\", \"msg\": \"\"}}"
        let resData = jsonString.data(using: .utf8)
        MockURLProtocol.stubResponseData = resData
        
        let expectation = self.expectation(description: "API Request Response Expectation")
        
        // Act
        sut.sendRequest { (result) in
            switch result {
            case .success(let data):
                // Assert
                XCTAssertEqual(data, resData)
                expectation.fulfill()
            case .failure(_):
                XCTFail("It should be return error")
            }
            
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testAPIRequest_WhenURLRequestFails_ErrorTookPlace() {
        MockURLProtocol.error = APIError.failedRequest(description: "")
        
        let expectation = self.expectation(description: "API Request expectation for a fail request")
        
        // Act
        sut.sendRequest { (result) in
            switch result {
            case .success(_):
                // Assert
                XCTFail("It shouldn't be return data")
            case .failure(let error):
                XCTAssertEqual(error, APIError.failedRequest(description: error.localizedDescription))
                expectation.fulfill()
            }
            
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testSignupWebservice_WhenCorruptedURLStringProvided_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "A corrupted request URL string expectation")
        
        http = Http(path: "ĞĞĞĞ", method: .get, body: nil)
        sut.http = http
        
        // Act
        sut.sendRequest { (result) in
            switch result {
            case .success(_):
                // Assert
                XCTFail("It shouldn't be return data")
            case .failure(let error):
                XCTAssertEqual(error, APIError.invalidRequestURLString)
                expectation.fulfill()
            }
            
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
