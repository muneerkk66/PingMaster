//
//  APIEnvironment+Live.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
final class APIEnvironmentLive {
    fileprivate var currentEnvironment: AppEnvironment?

    init(currentEnvironment: AppEnvironment? = nil) {
        self.currentEnvironment = currentEnvironment
    }
}

extension APIEnvironmentLive: APIEnvironment {
    var environment: AppEnvironment {
        guard let currentEnvironment else {
            LogInfo("Environment not set. Initialize environment using apiKitEnvironment.initialize(with environment:)")
            return AppEnvironment.qa
        }
        return currentEnvironment
    }

    func set(to environment: AppEnvironment) {
        currentEnvironment = environment
    }
}
