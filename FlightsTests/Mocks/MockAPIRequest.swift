//
//  MockAPIRequest.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockAPIRequest: APIRequestDelegate {
    
    var shouldCompleteWithError = false
    var error: APIError = .failedRequest(description: "")
    
    var http: Http!
    
    func sendRequest(completion: @escaping APIRequestCompletionType) {
        guard shouldCompleteWithError else {
            let jsonString = "{\"result\": {\"retcode\": \"0\", \"msg\": \"\"}}"
            guard let data = jsonString.data(using: .utf8) else {
                completion(.failure(.invalidResponseModel))
                return
            }
            completion(.success(data))
            return
        }
        completion(.failure(error))
    }
}
