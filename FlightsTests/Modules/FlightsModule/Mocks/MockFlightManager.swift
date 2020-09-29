//
//  MockFlightManager.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockFlightManager: FlightManagerProtocol {
    
    var shouldHaveError = false
    
    func getAllStates(longMin: Double, latMin: Double,
                      longMax: Double, latMax: Double,
                      completion: @escaping (_ result: Result<Flight.Response.AllStates, APIError>) -> Void) {
        if shouldHaveError {
            completion(.failure(APIError.invalidRequestURLString))
            return
        }
        completion(.success(Flight.Response.AllStates(time: 123123, states: [])))
    }
}
