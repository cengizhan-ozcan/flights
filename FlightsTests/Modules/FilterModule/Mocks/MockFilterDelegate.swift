//
//  MockFilterDelegate.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockFilterDelegate: FilterModuleDelegate {
    
    var country: String?
    
    func filteredCountry(_ country: String?) {
        self.country = country
    }
    
}
