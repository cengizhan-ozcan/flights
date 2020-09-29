//
//  MockFlightsInteractor.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockFlightsInteractor: PIFlightsProtocol {
    
    var presenter: IPFlightsProtocol?
    var isFetching = false
    var isFiltered = false
    var filteredCountry: String?
    
    func fetchFlights(longMin: Double, latMin: Double, longMax: Double, latMax: Double) {
        self.isFetching = true
    }
    
    func filterFlights(with country: String?) {
        self.isFiltered = true
        self.filteredCountry = country
    }
    
    
}
