//
//  AppEnvironment.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

enum AppEnvironment: String, Codable, CaseIterable {
	case development = "dev"
	case qa
	case production = "prod"
}

// TODO: Update environemnt variables based on the server.
extension AppEnvironment {
	var baseURL: URL {
		switch self {
		case .development:
			return URL(string: "https://gist.githubusercontent.com")!
		case .qa:
			return URL(string: "https://gist.githubusercontent.com")!
		case .production:
			return URL(string: "https://gist.githubusercontent.com")!
		}
	}
}
