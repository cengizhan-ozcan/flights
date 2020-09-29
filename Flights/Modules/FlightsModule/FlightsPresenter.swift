//
//  FlightsPresenter.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/17/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class FlightsPresenter: VPFlightsProtocol {
    
    // MARK: Properties
    weak var view: PVFlightsProtocol?
    var interactor: PIFlightsProtocol?
    var router: PRFlightsProtocol?
    
    private var filteredCountry: String?
    
    func onMapRegionChange(longMin: Double, latMin: Double, longMax: Double, latMax: Double) {
        view?.setLoading(isVisible: true)
        interactor?.fetchFlights(longMin: longMin, latMin: latMin, longMax: longMax, latMax: latMax)
    }
    
    func onFilterTap() {
        router?.showFilterModule(view: view!, delegate: self, filter: self.filteredCountry)
    }
    
}

extension FlightsPresenter: IPFlightsProtocol {
    
    func onGetStateAllSuccess(states: [[QuantumValue]]) {
        let flights: [FlightDM] = states.compactMap({
            let flight = FlightDM(icao24: $0[0].value as? String ?? "",
                                callSign: $0[1].value as? String,
                                countryOrigin: $0[2].value as? String ?? "",
                                longitude: $0[5].value as? Float,
                                latitude: $0[6].value as? Float,
                                velocity: $0[9].value as? Float,
                                trueTrack: $0[10].value as? Float)
            return flight
        })
        view?.showFlights(flights, filteredCountry: self.filteredCountry)
        view?.setLoading(isVisible: false)
    }
    
    func onGetStateAllFailure(error: APIError) {
        router?.showErrorAlert(view: view!, with: error.errorDescription ?? "Error Occured.")
        view?.setLoading(isVisible: false)
    }
    
    func autoFetchStart() {
        view?.setLoading(isVisible: true)
    }
}

extension FlightsPresenter: FilterModuleDelegate {
    
    func filteredCountry(_ country: String?) {
        self.filteredCountry = country
        self.interactor?.filterFlights(with: country)
    }
}
