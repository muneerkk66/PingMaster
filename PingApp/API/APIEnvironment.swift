//
//  APIEnvironment.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
protocol APIEnvironment {
	var environment: AppEnvironment { get }
	func set(to environment: AppEnvironment)
}
