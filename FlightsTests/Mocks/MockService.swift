//
//  MockService.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockService: ServiceDelegate {
    
    var shouldReturnError = false
    var error: APIError = .failedRequest(description: "")
    var callTimes = 0
    
    
    func send<T, R>(api: API, request: T?, completion: @escaping (Result<R, APIError>) -> Void) where T : Decodable, T : Encodable, R : GenericRespLogic {
        callTimes += 1
        if shouldReturnError {
            completion(.failure(error))
            return
        }
        let obj = initatiateObject(type: R.self)
        completion(.success(obj))
    }
    
    func send<R>(api: API, completion: @escaping (Result<R, APIError>) -> Void) where R : GenericRespLogic {
        send(api: api, request: Optional<GenericResp>.none, completion: completion)
    }
    
    func initatiateObject<R: GenericRespLogic>(type: R.Type) -> R {
        return R.init()
    }
    
}
