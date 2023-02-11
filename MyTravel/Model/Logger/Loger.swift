//
//  Logger.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/11/26.
//

import Foundation

class Logger {
    
    private init(){}
    
    static func log<T>(message: T, method: String = #function) {
        #if DEBUG
        NSLog("[will - Method: \(method), Message: \(message)]")
        #endif
    }
}
