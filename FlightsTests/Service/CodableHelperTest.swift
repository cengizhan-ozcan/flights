//
//  CodableHelperTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class CodableHelperTest: XCTestCase {
    
    var codableHelper: CodableHelperDelegate!
    
    override func setUp() {
        super.setUp()
        codableHelper = CodableHelper()
    }
    
    override func tearDown() {
        super.tearDown()
        codableHelper = nil
    }
    
    func testCodableHelper_WhenGivenEncodableData_ReturnsObject() {
        // Assert
        let mockCodable = MockCodable(test: 1.0)
        // Act
        let data = codableHelper.encode(requestObj: mockCodable)
        // Assert
        XCTAssertNotNil(data, "Encodable object shouldn't be nil")
    }
    
    func testCodableHelper_WhenGivenCorruptedEncodableData_ReturnsNil() {
        // Assert
        let mockCodable = MockCodable(test: Double.infinity)
        // Act
        let data = codableHelper.encode(requestObj: mockCodable)
        // Assert
        XCTAssertNil(data, "Encodable object should be nil")
    }
    
    func testCodableHelper_WhenGivenDecodableData_ReturnsObject() {
        // Arrange
        if let jsonData = "{\"time\": 1600286800, \"states\": [[\"1\"]]}".data(using: .utf8) {
            // Act
            let object = codableHelper.decode(type: GenericResp.self, data: jsonData)
            // Assert
            XCTAssertNotNil(object, "Decodable object shouldn't be nil")
            XCTAssertEqual(object?.time, 1600286800)
            return
        }
        XCTFail("JSON cannot be used as a Data")
    }
    
    func testCodableHelper_WhenGivenDecodableDataHasNotKey_ReturnsNil() {
        // Arrange
        if let jsonData = "{\"states\": [[\"1\"]]}".data(using: .utf8) {
            // Act
            let object = codableHelper.decode(type: MockCodable.self, data: jsonData)
            // Assert
            XCTAssertNil(object, "Decodable object should be nil")
            return
        }
        XCTFail("JSON cannot be used as a Data")
    }
    
    func testCodableHelper_WhenGivenDecodableDataHasTypeMismatch_ReturnsNil() {
        // Arrange
        if let jsonData = "{\"time\": \"1600286800\", \"states\": [[\"1\"]]}".data(using: .utf8) {
            // Act
            let object = codableHelper.decode(type: GenericResp.self, data: jsonData)
            // Assert
            XCTAssertNil(object?.time, "Result object should be nil")
            return
        }
        XCTFail("JSON cannot be used as a Data")
    }
    
    func testCodableHelper_WhenGivenDecodableDataHasValueMismatch_ReturnsNil() {
        // Arrange
        if let jsonData = "{\"test\": null}".data(using: .utf8) {
            // Act
            let object = codableHelper.decode(type: MockCodable.self, data: jsonData)
            // Assert
            XCTAssertNil(object, "Decodable object should be nil")
            return
        }
        XCTFail("JSON cannot be used as a Data")
    }
    
    func testCodableHelper_WhenGivenDecodableDataIsCorrupted_ReturnsNil() {
        // Arrange
        if let jsonData = "{\"time\" \"\"}".data(using: .utf8) {
            // Act
            let object = codableHelper.decode(type: GenericResp.self, data: jsonData)
            // Assert
            XCTAssertNil(object, "Decodable object should be nil")
            return
        }
        XCTFail("JSON cannot be used as a Data")
    }
    
}
