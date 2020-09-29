//
//  MockCodableHelper.swift
//  FlightsTests
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation
@testable import Flights

class MockCodableHelper: CodableHelperDelegate {
    
    var isDecodeFuncCalled = false
    var isEncodeFuncCalled = false
    var shouldReturnNil = false
    
    func decode<T>(type: T.Type, data: Data) -> T? where T : Decodable {
        isDecodeFuncCalled = true
        guard shouldReturnNil else {
            let object = GenericResp()
            return object as? T
        }
        return nil
    }
    
    func encode<T>(requestObj: T) -> Data? where T : Encodable {
        isEncodeFuncCalled = true
        guard shouldReturnNil else {
            let data = Data()
            return data
        }
        return nil
    }
    
}
