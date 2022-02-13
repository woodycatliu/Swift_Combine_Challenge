//
//  Log.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import Foundation

class Logger {
    
    private init() {
    }
    
    static func log<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        NSLog("######## [\(fileName): \(method)] \(message)  - at Line \(line) #######")
        #endif
    }
    
    static func log<T, U>(message: T, caller: U, method: String = #function, line: Int = #line) {
        #if DEBUG
        NSLog("####### [\(caller).\(method)] \(message) - at Line \(line) #######")
        #endif
    }

    static func log<T>(message: T, file: String = #file, _class: AnyObject, method: String = #function, line: Int = #line) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let className = NSStringFromClass(type(of: _class))
        NSLog("#### [\(className).\(method)]- \(message) at fileName: \(fileName) - at Line \(line) ####")
        #endif

    }
    
    static func log<T, U>(message: T, apiCaller: U, line: Int = #line) {
        #if DEBUG
        NSLog("#### [\(apiCaller)] \(message) - at Line \(line) ####")
        #endif
    }


}
