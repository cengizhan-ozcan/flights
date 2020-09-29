//
//  FlightsInteractor.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/17/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

class FlightsInteractor {
    
    // MARK: Properties
    weak var presenter: IPFlightsProtocol?

    var manager: FlightManagerProtocol = FlightManager()
    var countryFilter: String?
    var timer: Timer?
    let interval: TimeInterval = 5
    var states: [[QuantumValue]] = []
    var filteredStates: [[QuantumValue]] = []
    
    deinit {
        timer?.invalidate()
    }
    
    private func getAllStates(longMin: Double, latMin: Double, longMax: Double, latMax: Double) {
        manager.getAllStates(longMin: longMin, latMin: latMin, longMax: longMax, latMax: latMax) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let resp):
                self.states = resp.states ?? []
                guard let _ = self.countryFilter else {
                    self.presenter?.onGetStateAllSuccess(states: self.states)
                    return
                }
                self.filteredStates = self.getFilteredStates()
                self.presenter?.onGetStateAllSuccess(states: self.filteredStates)
            case .failure(let error):
                self.presenter?.onGetStateAllFailure(error: error)
            }
        }
    }
    
    private func startTimer(longMin: Double, latMin: Double, longMax: Double, latMax: Double) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(fireTimer(_:)),
                                     userInfo: ["longMin": longMin, "latMin": latMin,
                                                "longMax": longMax, "latMax": latMax],
                                     repeats: true)
    }
    
    @objc private func fireTimer(_ sender: Timer) {
        guard let userInfo = sender.userInfo as? [String:Double],
            let longMin = userInfo["longMin"],
            let latMin = userInfo["latMin"],
            let longMax = userInfo["longMax"],
            let latMax = userInfo["latMax"]
            else { return }
        presenter?.autoFetchStart()
        getAllStates(longMin: longMin, latMin: latMin, longMax: longMax, latMax: latMax)
    }
    
    private func getFilteredStates() -> [[QuantumValue]] {
        let stateList = self.states.filter({
            guard let country = $0[2].value as? String else { return false }
            return country.lowercased() == self.countryFilter?.lowercased()
        })
        return stateList
    }
    
}

extension FlightsInteractor: PIFlightsProtocol {    
    
    func fetchFlights(longMin: Double, latMin: Double, longMax: Double, latMax: Double) {
        getAllStates(longMin: longMin, latMin: latMin, longMax: longMax, latMax: latMax)
        startTimer(longMin: longMin, latMin: latMin, longMax: longMax, latMax: latMax)
    }
    
    func filterFlights(with country: String?) {
        self.countryFilter = country
        guard let _ = self.countryFilter else {
            self.presenter?.onGetStateAllSuccess(states: self.states)
            return
        }
        self.filteredStates = getFilteredStates()
        self.presenter?.onGetStateAllSuccess(states: self.filteredStates)
    }
}
