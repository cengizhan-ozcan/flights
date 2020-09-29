//
//  APIError.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum APIError: Error, Equatable {
    
    case invalidRequestURLString
    case invalidResponseModel
    case failedRequest(description: String)
    
    var errorDescription: String? {
           switch self {
           case .failedRequest(let description):
               return description
           case .invalidRequestURLString, .invalidResponseModel:
               return ""
           }
       }
}
