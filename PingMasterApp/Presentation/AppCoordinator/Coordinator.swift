//
//  Coordinator.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

protocol Coordinator: ObservableObject where Screen: Routable {
    associatedtype Screen
    var navigationPath: [Screen] { get }
}
