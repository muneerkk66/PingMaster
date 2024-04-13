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

    func findHostsLatency(hosts: [String]) -> AnyPublisher<LatencyResult, APIError> {
        return latencyService
            .findLatency(hosts: hosts)
            .mapError {_ in
                return APIError.connectionError
            }
            .map {(host, latency) -> LatencyResult in
                let result = LatencyResult(host: host, latency: latency ?? 0, imageUrl: nil)
                return result
            }.eraseToAnyPublisher()
    }
}
