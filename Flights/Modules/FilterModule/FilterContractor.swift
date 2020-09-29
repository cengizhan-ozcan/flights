//
//  FilterContractor.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

// MARK: Segue Data
protocol SegueDataProtocol {
    var filter: String? { get set }
}

// MARK: View Input (View -> Presenter)
protocol VPFilterProtocol {
    var view: PVFilterProtocol? { get set }
    var interactor: PIFilterProtocol? { get set }
    var router: PRFilterProtocol? { get set }
    
    var delegate: FilterModuleDelegate? { get set }
    func onFilter(with country: String?)
    func dismiss()
    func getInitialFilter() -> String?
}

// MARK: View Output (Presenter -> View)
protocol PVFilterProtocol: class {
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PIFilterProtocol: class {
    var presenter: IPFilterProtocol? { get set }
    
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol IPFilterProtocol: class {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PRFilterProtocol {
    static func createModule(delegate: FilterModuleDelegate, filter: String?) -> UIViewController
    func dismiss(view: PVFilterProtocol)
}

protocol FilterModuleDelegate {
    func filteredCountry(_ country: String?)
}
