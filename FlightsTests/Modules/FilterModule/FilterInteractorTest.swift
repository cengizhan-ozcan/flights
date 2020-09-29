//
//  FilterInteractorTest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import XCTest
@testable import Flights

class FilterInteractorTest: XCTestCase {
    
    var sut: FilterInteractor?
    var presenter: MockFilterPresenter?

    override func setUp() {
        super.setUp()
        sut = FilterInteractor()
        presenter = MockFilterPresenter()
        sut?.presenter = presenter
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        presenter = nil
    }
    
    func testFilterInteractor_WhenInteractorCreated_PresenterShouldNotNil() {
        XCTAssertNotNil(sut?.presenter)
    }

}
