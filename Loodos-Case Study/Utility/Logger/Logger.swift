//
//  Logger.swift
//  Loodos-Case Study
//
//  Created by ali dölen on 16.10.2022.
//

import Foundation

struct Logger {
    
    enum LogType: String {
        case pageInit = "INIT: ->"
        case deinitPage = "DEINIT: ->"
        case error = "Job Failed: -> "
        case success = "Task Done for: ->"
    }
    
    static func log(_ logType: LogType, _ message: String) {
        print(logType.rawValue, message)
    }
}
