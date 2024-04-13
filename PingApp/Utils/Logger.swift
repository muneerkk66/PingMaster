//
//  Logger.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
import OSLog

/// This method is functionally equivilent to the debug(_:) method.
public func LogTrace(_ message: @escaping @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
	Logger().trace(
		"""
\(line):\(function):\(file)
TRACE 🐾: \(message())
.
"""
	)
}

/// Use this method to write messages with the debug log level to the in-memory log store only.
public func LogDebug(_ message: @escaping @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
	Logger().debug(
		"""
\(line):\(function):\(file)
DEBUG 🐛: \(message())
.
"""
	)
}

/// Use this method to write messages with the debug log level to both the in-memory and on-disk log stores.
public func LogVerbose(_ message: @escaping @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
	Logger().notice(
		"""
\(line):\(function):\(file)
VERBOSE 📚: \(message())
.
"""
	)
}

/// Use this method to write messages with the info log level to the in-memory log store only. If you use the log command line tool to collect your logs, the method also writes messages to the on-disk log store.
public func LogInfo(_ message: @escaping @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
	Logger().info(
		"""
\(line):\(function):\(file)
INFO 📡: \(message())
.
"""
	)
}

/// This method is functionally equivalent to the error(_:) method.
public func LogWarning(_ message: @escaping @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
	Logger().warning(
		"""
\(line):\(function):\(file)
WARNING ⚠️: \(message())
.
"""
	)
}

/// Use this method to write messages with the error log level to both the in-memory and on-disk log stores.
public func LogError(_ message: @escaping @autoclosure () -> String, file: String = #file, function: String = #function, line: UInt = #line) {
	Logger().error(
		"""
\(line):\(function):\(file)
ERROR ❌: \(message())
.
"""
	)
}

/// Use this method to write messages with the fault log level to both the in-memory and on-disk log stores.
public func LogFatal(_ message: String, file: String = #file, function: String = #function, line: UInt = #line) -> Never {
	Logger().critical(
		"""
\(line):\(function):\(file)
FATAL ☢️: \(message)
.
"""
	)
	fatalError(message)
}
