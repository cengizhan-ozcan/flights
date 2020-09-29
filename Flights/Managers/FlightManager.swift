//
//  FlightManager.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

protocol FlightManagerProtocol{
    func getAllStates(longMin: Double, latMin: Double,
                      longMax: Double, latMax: Double,
                      completion: @escaping (_ result: Result<Flight.Response.AllStates, APIError>) -> Void)
}

struct FlightManager: FlightManagerProtocol {
    
    private var service: ServiceDelegate!
    
    init(service: ServiceDelegate = MainService.shared) {
        self.service = service
    }
    
    func getAllStates(longMin: Double, latMin: Double,
                      longMax: Double, latMax: Double,
                      completion: @escaping (_ result: Result<Flight.Response.AllStates, APIError>) -> Void) {
        service.send(api: .statesAll(longMin: longMin, latMin: latMin,
                                     longMax: longMax, latMax: latMax),
                     completion: completion)
    }
}
