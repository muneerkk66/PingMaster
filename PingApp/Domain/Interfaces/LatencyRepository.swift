//
//  LatencyRepository.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine
protocol LatencyRepository {
    func findHostsLatency(hosts: [String]) -> AnyPublisher<LatencyResult, APIError>
}
