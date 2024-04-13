//
//  Resolver.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

import Swinject
import NetworkPinger

// Resolver is a singleton class that is responsible for injecting all dependencies in the app.
final class Resolver {

    static let shared = Resolver()

    private var container = Container()

    // This method is responsible for injecting all dependencies in the app.
    // MARK: This can be load on demand
    @MainActor func injectModules() {

        injectUtils()
        injectCoordinator()
        injectServices()
        injectRepositories()
        injectUseCases()
        injectViewModels()
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

        container.register(NetworkPinger.self) { _ in
            NetworkPinger()
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

// MARK: - Injecting Services -

extension Resolver {
    private func injectServices() {
        container.register(HostServiceLive.self) { resolver in
            HostServiceLive(apiClient: resolver.resolve(APIClientLive.self)!)
        }.inObjectScope(.container)

        container.register(LatencyServiceLive.self) { resolver in
            LatencyServiceLive(pinger: resolver.resolve(NetworkPinger.self)!)
        }.inObjectScope(.container)

    }
}

// MARK: - Injecting Repositories -

extension Resolver {

    private func injectRepositories() {
        container.register(HostRepositoryLive.self) { resolver in
            HostRepositoryLive(hostService: resolver.resolve(HostServiceLive.self)!)
        }.inObjectScope(.container)

        container.register(LatencyRepositoryLive.self) { resolver in
            LatencyRepositoryLive(latencyService: resolver.resolve(LatencyServiceLive.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting Use Cases -

extension Resolver {

    private func injectUseCases() {
        container.register(FetchAllHostsUseCaseLive.self) { resolver in
            FetchAllHostsUseCaseLive(hostRepository: resolver.resolve(HostRepositoryLive.self)!)
        }.inObjectScope(.container)

        container.register(FindLatencyUseCaseLive.self) { resolver in
            FindLatencyUseCaseLive(latencyRepository: resolver.resolve(LatencyRepositoryLive.self)!)
        }.inObjectScope(.container)

    }
}

// MARK: - Injecting ViewModels -

extension Resolver {

    @MainActor
    private func injectViewModels() {
        container.register(HomeViewModel.self) { resolver in
            HomeViewModel(coordinator: resolver.resolve(HomeCoordinator.self)!, fetchHostsUseCase: resolver.resolve(FetchAllHostsUseCaseLive.self)!, findLatencyUseCase: resolver.resolve(FindLatencyUseCaseLive.self)!)
        }
    }
}
