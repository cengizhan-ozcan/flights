//
//  Logger.swift
//  Flights
//
//  Created by Cengizhan Özcan on 9/16/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import Foundation

enum LogLevel {
    case info
    case error
}

class Logger {
    
    private init() {}
    
    class func log(_ message: String, level: LogLevel) {
        switch level {
        case .info:
            Logger.show(message: message, level: .info)
        case .error:
            Logger.show(message: message, level: .error)
        }
    }
    
    private class func show(message: String, level: LogLevel) {
        let msg = "\(Logger.getLevelInfo(for: level)) \(message)"
        guard Configuration.isDebug else {return}
        print(msg)
    }
    
    private class func getLevelInfo(for level: LogLevel) -> String {
        switch level {
        case .info:
            return "📗Info->"
        case .error:
            return "📕Error->"
        }
    }
}
