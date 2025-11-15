//
//  Log.swift
//  Tmsscanios
//
//  Created by fleon  on 6/9/24.
//

import Foundation

public enum LogLevel: Int, Sendable {
    case debug
    case info
    case warning
    case error
    case request
    case response
    
    func symbol() -> String {
        switch self {
        case .debug: return "🦠"
        case .info: return "✅"
        case .warning: return "⚠️"
        case .error: return "❌"
        case .request: return "➡️"
        case .response: return "⬅️"
        }
    }
    
    func name() -> String {
        switch self {
        case .debug: return "DEBUG"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .request: return "REQUEST"
        case .response: return "RESPONSE"

        }
    }
}

@globalActor
actor LogManagerActor {
    static let shared = LogManagerActor()
    private var level: LogLevel = .debug
    
    private init() {}
    
    func setLogLevel(_ level: LogLevel) {
        self.level = level
    }
    
    func getLogLevel() -> LogLevel {
        return self.level
    }
}

public final class Logger {
    public static func setLogLevel(_ level: LogLevel) {
        Task {
            await LogManagerActor.shared.setLogLevel(level)
        }
    }
    
    public static func debug(_ message: String,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        log(.debug, message, file: file, function: function, line: line)
    }
    
    public static func info(_ message: String,
                            file: String = #file,
                            function: String = #function,
                            line: Int = #line) {
        log(.info, message, file: file, function: function, line: line)
    }
    
    public static func warning(_ message: String,
                               file: String = #file,
                               function: String = #function,
                               line: Int = #line) {
        log(.warning, message, file: file, function: function, line: line)
    }
    
    public static func error(_ message: String,
                             file: String = #file,
                             function: String = #function,
                             line: Int = #line) {
        log(.error, message, file: file, function: function, line: line)
    }
    
    public static func request(_ message: String,
                                file: String = #file,
                                function: String = #function,
                                line: Int = #line) {
        log(.request, message, file: file, function: function, line: line)
    }
    
    public static func response(_ message: String,
                                file: String = #file,
                                function: String = #function,
                                line: Int = #line) {
        log(.response, message, file: file, function: function, line: line)
    }
}

extension Logger {
    private static func log(_ logLevel: LogLevel,
                            _ message: String,
                            file: String,
                            function: String,
                            line: Int) {
        Task {
            await LogManagerActor.shared.handleLog(logLevel, message, file: file, function: function, line: line)
        }
    }
}

extension LogManagerActor {
    func handleLog(_ logLevel: LogLevel,
                   _ message: String,
                   file: String,
                   function: String,
                   line: Int) {
        let resolvedMessage = String(describing: message)
        
        let fileName = (file as NSString).lastPathComponent
        let logSymbol = logLevel.symbol()
        let timestamp = self.getCurrentTime()
        
        let formattedLog = """
            \(logSymbol) [\(logLevel.name())] [\(fileName) -> \(function) -> Line \(line)] [\(timestamp)]
            \(resolvedMessage)
            """
        
        print(formattedLog)
    }
    
    private nonisolated func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }
}

