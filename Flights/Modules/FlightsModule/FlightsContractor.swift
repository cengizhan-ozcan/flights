//
//  FlightsContractor.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/17/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

// MARK: View Input (View -> Presenter)
protocol VPFlightsProtocol {
    var view: PVFlightsProtocol? { get set }
    var interactor: PIFlightsProtocol? { get set }
    var router: PRFlightsProtocol? { get set }
    
    func onMapRegionChange(longMin: Double, latMin: Double, longMax: Double, latMax: Double)
    func onFilterTap()
}

// MARK: View Output (Presenter -> View)
protocol PVFlightsProtocol: class {
    func showFlights(_ flights: [FlightDM], filteredCountry: String?)
    func setLoading(isVisible: Bool)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PIFlightsProtocol: class {
    var presenter: IPFlightsProtocol? { get set }
    func fetchFlights(longMin: Double, latMin: Double, longMax: Double, latMax: Double)
    func filterFlights(with country: String?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol IPFlightsProtocol: class {
    func onGetStateAllSuccess(states: [[QuantumValue]])
    func onGetStateAllFailure(error: APIError)
    func autoFetchStart()
}

// MARK: Router Input (Presenter -> Router)
protocol PRFlightsProtocol {
    static func createModule() -> UIViewController
    func showFilterModule(view: PVFlightsProtocol, delegate: FilterModuleDelegate, filter: String?)
    func showErrorAlert(view: PVFlightsProtocol, with message: String)
}
