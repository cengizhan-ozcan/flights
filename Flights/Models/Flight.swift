//
//  FlightModel.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/17/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum Flight {
    
    enum Request {}
    
    enum Response {
        
        struct AllStates: GenericRespLogic {
            var time: Int!
            var states: [[QuantumValue]]?
        }
    }
}
