//
//  HomeCoordinatorView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

struct HomeCoordinatorView: View {
    @ObservedObject private var coordinator: HomeCoordinator = Resolver.shared.resolve(HomeCoordinator.self)

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            HomeView()
                .navigationDestination(for: HomeCoordinator.Screen.self) {
                    destination($0)
                }
                .navigationTitle("PingApp")
        }
    }

    @ViewBuilder
    private func destination(_ screen: HomeCoordinator.Screen) -> some View {
        switch screen {
        case .details(let latency):
            DetailView(latency: latency)
        }
    }
}
