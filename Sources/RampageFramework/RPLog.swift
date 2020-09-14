//
//  RPLog.swift
//  Naraya
//
//  Created by narongrit kanhanoi on 18/9/2562 BE.
//  Copyright © 2562 narongrit kanhanoi. All rights reserved.
//

import Foundation
import UIKit

public class RPLog {
    
    private static func getFileName(_ file: String) -> String {
        return file.components(separatedBy: "/").last ?? ""
    }
    
    static public func debug(_ msg: Any, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
            let line = "\(getFileName(file)):\(line) : \(function)"
            print("\(line)\n\(Date())💙 [DEBUG] ", msg)
        #endif
    }

    static public func warn(_ msg: Any, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
            let line = "\(getFileName(file)):\(line) : \(function)"
            print("\(line)\n\(Date())💛 [WARN] ", msg)
        #endif
    }

    static public func error(_ msg: Any, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
            let line = "\(getFileName(file)):\(line) : \(function)"
            print("\(line)\n\(Date())💔 [ERROR] ", msg)
        #endif
    }

}

