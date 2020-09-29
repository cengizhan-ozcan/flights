//
//  FilterPresenter.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

class FilterPresenter: VPFilterProtocol {
    
    // MARK: Properties
    weak var view: PVFilterProtocol?
    var interactor: PIFilterProtocol?
    var router: PRFilterProtocol?
    
    var delegate: FilterModuleDelegate?
    var filter: String?
    
    func onFilter(with country: String?) {
        let filteredCountry = country != "" ? country : nil
        delegate?.filteredCountry(filteredCountry)
        router?.dismiss(view: view!)
    }
    
    func dismiss() {
        router?.dismiss(view: view!)
    }
    
    func getInitialFilter() -> String? {
        return self.filter
    }
}

extension FilterPresenter: IPFilterProtocol {
    
}

extension FilterPresenter: SegueDataProtocol {
    
}
