//
//  AppEnvironment.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

// MARK: This file facilitates the management of API endpoints and their associated keys. For enhanced security, Arakana encryption is utilized for handling API keys.
// MARK: Store your keys and secrets away from your source code ,use Arkana keys : https://github.com/rogerluan/arkana

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
