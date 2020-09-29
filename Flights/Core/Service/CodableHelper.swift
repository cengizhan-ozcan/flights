//
//  CodableHelper.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

protocol CodableHelperDelegate {
    func decode<T: Decodable>(type: T.Type, data: Data) -> T?
    func encode<T: Encodable>(requestObj: T) -> Data?
}

class CodableHelper: CodableHelperDelegate {
    
    func decode<T: Decodable>(type: T.Type, data: Data) -> T? {
        
        let decodeError: (_ context: DecodingError.Context, _ msg: String) -> String = { context, msg in
            return "<Type: \(msg), path: \(context.codingPath.map({ return $0.stringValue })), message: \(context.debugDescription)"
        }
        
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch DecodingError.typeMismatch(_, let context) {
            Logger.log(decodeError(context, "Type Mismatch"), level: .error)
        } catch DecodingError.keyNotFound(_, let context) {
            Logger.log(decodeError(context, "Key Not Found"), level: .error)
        } catch DecodingError.valueNotFound(_, let context) {
            Logger.log(decodeError(context, "Value Not Found"), level: .error)
        } catch DecodingError.dataCorrupted(let context) {
            Logger.log(decodeError(context, "Data Corrupted"), level: .error)
        } catch let error {
            Logger.log("\(error)", level: .error)
        }
        return nil
    }
    
    func encode<T: Encodable>(requestObj: T) -> Data? {
        do {
            let object = try JSONEncoder().encode(requestObj.self)
            return object
        } catch EncodingError.invalidValue(let key, let context) {
            Logger.log("\(key), \(context)", level: .error)
        } catch let error {
            Logger.log("Encode Error: \(error.localizedDescription)" , level: .error)
        }
        return nil
    }
}

