//
//  Logger.swift
//  AppnomiCase
//
//  Created by Murat Çiçek on 10.09.2022.
//

import Foundation
import UIKit

enum LoggerType {
    case info
    case error
    case warning
    var icon: String {
        switch self {
        case .info:
            return "ℹ️"
        case .error:
            return "❌"
        case .warning:
            return "⚠️"
        }
    }
}

struct Logger {
    static func log(type: LoggerType = .info, text: String, file: String = #file, function: String = #function, line: Int = #line) {
        print("\(type.icon) [Appnomi] [File:\(file)]\n[Function:\(function)]\n[Line:\(line.toString)] \n\(text)")
    }
}
