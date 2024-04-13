//
//  HostsRepository.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
import Combine

final class LatencyRepositoryLive: LatencyRepository {

    private let latencyService: LatencyService

    init(latencyService: LatencyService) {
        self.latencyService = latencyService
    }

    func findHostsLatency(hosts: [String]) -> AnyPublisher<(String, Double?), Error> {
        guard NetworkMonitor.shared.isConnected else { return Fail(error: APIError.connectionError).eraseToAnyPublisher()}
        return latencyService
            .findLatency(hosts: hosts)
    }
}
