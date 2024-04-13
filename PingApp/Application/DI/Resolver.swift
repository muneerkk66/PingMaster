//
//  Resolver.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

import Swinject

// Resolver is a singleton class that is responsible for injecting all dependencies in the app.
final class Resolver {

    static let shared = Resolver()

    private var container = Container()

    // This method is responsible for injecting all dependencies in the app.
    @MainActor func injectModules() {

		injectUtils()
		injectCoordinator()
    }
    /// - Parameter type: The type of the dependency to be resolved.
    /// - Returns: The resolved dependency.
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

// MARK: - Injecting Utils -

extension Resolver {
	private func injectUtils() {

		// MARK: Update Server Environment
		// Note: The server is currently set to the development environment. This configuration can also be adjusted using the Build Config method within the CI/CD pipeline as needed.
		
		container.register(APIEnvironmentLive.self) { _ in
			APIEnvironmentLive(currentEnvironment: AppEnvironment.development)

		}.inObjectScope(.container)
		container.register(APIClientLive.self) { resolver in
			APIClientLive(apiEnvironment: resolver.resolve(APIEnvironmentLive.self)!)
		}.inObjectScope(.container)

	}
}

// MARK: - Injecting Coordinator -

extension Resolver {
	private func injectCoordinator() {
		container.register(AppCoordinator.self) { _ in
			AppCoordinator()
		}.inObjectScope(.container)

		container.register(HomeCoordinator.self) { _ in
			HomeCoordinator()
		}.inObjectScope(.container)

	}
}
