//
//  MockFlightsVC.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit
@testable import Flights

class MockFlightsVC: PVFlightsProtocol {
    
    var isLoading = false
    var filteredCountry: String?
    var flights: [FlightDM]?
    
    func showFlights(_ flights: [FlightDM], filteredCountry: String?) {
        self.filteredCountry = filteredCountry
        self.flights = flights
    }
    
    func setLoading(isVisible: Bool) {
        isLoading = isVisible
    }
    
    
}
