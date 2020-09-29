//
//  Configuration.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

struct Configuration {
    
    static let baseURL = "https://\(Configuration.openskyUsername):\(Configuration.openskyPassword)@opensky-network.org/api/"
    
    static let openskyUsername = "cengizhanozcan"
    static let openskyPassword = "123456789"
    static let isDebug = true
    
}
