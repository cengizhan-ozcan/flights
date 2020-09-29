//
//  MockFlightsRouter.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit
@testable import Flights

class MockFlightsRouter: PRFlightsProtocol {
   
    var isFilterModuleShown = false
    var isErrorAlertShown = false
    var errorMessage = ""
    
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
    func showFilterModule(view: PVFlightsProtocol, delegate: FilterModuleDelegate, filter: String?) {
           self.isFilterModuleShown = true
    }
    
    func showErrorAlert(view: PVFlightsProtocol, with message: String) {
        self.isErrorAlertShown = true
        self.errorMessage = message
    }
    
    
    
}
