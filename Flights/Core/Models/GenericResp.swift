//
//  GenericResp.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

protocol GenericRespLogic: Codable {
    var time: Int! { get }
    init()
}

struct GenericResp: GenericRespLogic {
    
    var time: Int!
    
}

