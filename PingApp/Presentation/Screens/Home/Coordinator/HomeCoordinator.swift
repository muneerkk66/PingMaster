//
//  HomeCoordinator.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

final class HomeCoordinator: Coordinator {
    enum Screen: Routable {
        case details(String)
    }
    @Published var navigationPath = [Screen]()

}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func showDetailView(host: String) {
        navigationPath.append(.details(host))
    }
}
