//
//  APIPath.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum API {
    
    case statesAll(longMin: Double, latMin: Double, longMax: Double, latMax: Double)
    
    var endpoint: (path: String, method: HttpMethod) {
        switch self {
        case .statesAll(let longMin, let latMin, let longMax, let latMax):
            return ("states/all?lomin=\(longMin)&lamin=\(latMin)&lomax=\(longMax)&lamax=\(latMax)", .get)
        }
    }
}
