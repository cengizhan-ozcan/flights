//
//  MockFilterRouter.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit
@testable import Flights

class MockFilterRouter: PRFilterProtocol {
    
    var isDismissCalled = false
    
    static func createModule(delegate: FilterModuleDelegate, filter: String?) -> UIViewController {
        return UIViewController()
    }
    
    func dismiss(view: PVFilterProtocol) {
        isDismissCalled = true
    }
}
