//
//  MockFlightsPresenter.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit
@testable import Flights

class MockFlightsPresenter: VPFlightsProtocol, IPFlightsProtocol, FilterModuleDelegate {
       
    var view: PVFlightsProtocol?
    var interactor: PIFlightsProtocol?
    var router: PRFlightsProtocol?
    
    var isFilterTapped = false
    var isMapRegionChangeCalled = false
    var states: [[QuantumValue]]?
    var error: APIError?
    
    func onMapRegionChange(longMin: Double, latMin: Double, longMax: Double, latMax: Double) {
        self.isMapRegionChangeCalled = true
    }
    
    func onFilterTap() {
        isFilterTapped = true
    }
    
    func onGetStateAllSuccess(states: [[QuantumValue]]) {
        self.states = states
    }
    
    func onGetStateAllFailure(error: APIError) {
        self.error = error
    }
    
    func autoFetchStart() {
        
    }
    
    func filteredCountry(_ country: String?) {
        
    }
    
    
}
