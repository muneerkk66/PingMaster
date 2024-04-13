//
//  LatencyService.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine
protocol LatencyService {
    @discardableResult
    func findLatency(hosts: [String]
    ) -> AnyPublisher<(String, Double?), Error>
}
