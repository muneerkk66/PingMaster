//
//  HomeCoordinatorProtocol.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

@MainActor
protocol HomeCoordinatorProtocol {
    func showDetailView(latency: String)
}
