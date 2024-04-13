//
//  AppCoordinator.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

final class AppCoordinator: ObservableObject {

    enum State {
        case idle
        case main
    }

    enum Action {
        case showMain
    }

    init() {state = .idle}

    @Published private(set) var state: State

    func handle(_ action: Action) {
        switch action {
        case .showMain:
            state = .main
        }
    }
}
