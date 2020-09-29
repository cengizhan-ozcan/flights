//
//  MockFilterPresenter.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockFilterPresenter: VPFilterProtocol, IPFilterProtocol, SegueDataProtocol {
    
    var view: PVFilterProtocol?
    var interactor: PIFilterProtocol?
    var router: PRFilterProtocol?
    var delegate: FilterModuleDelegate?
    var filter: String?
    
    var isDismissCalled = false
    var isOnFilterCalled = false
    
    func onFilter(with country: String?) {
        isOnFilterCalled = true
        filter = country
    }
    
    func dismiss() {
        isDismissCalled = true
    }
    
    func getInitialFilter() -> String? {
        return filter
    }
    
    
    
}
