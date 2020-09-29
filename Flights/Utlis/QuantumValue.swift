//
//  QuantumValue.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/19/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum QuantumValue: Codable {
    
    case int(Int)
    case string(String)
    case boolean(Bool)
    case float(Float)
    case null
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        if let boolean = try? decoder.singleValueContainer().decode(Bool.self) {
            self = .boolean(boolean)
            return
        }
        
        if let float = try? decoder.singleValueContainer().decode(Float.self) {
            self = .float(float)
            return
        }
        
        if let _ = try? decoder.singleValueContainer().decodeNil() {
            self = .null
            return
        }

        throw QuantumError.missingValue
    }
    
    var value: Any? {
        switch self {
        case .int(let value):
            return value
        case .string(let value):
            return value
        case .boolean(let value):
            return value
        case .float(let value):
            return value
        case .null:
            return nil
        }
    }
    
    func encode(to encoder: Encoder) throws {}
    
    enum QuantumError:Error {
        case missingValue
    }
}
