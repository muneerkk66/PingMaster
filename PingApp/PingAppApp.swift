//
//  PingAppApp.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

@main
struct PingAppApp: App {
    init() {
        // Injecting all dependencies
        Resolver.shared.injectModules()
    }

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView()
        }
    }
}
