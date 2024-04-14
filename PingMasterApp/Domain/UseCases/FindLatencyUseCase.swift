//
//  FetchAllHostsUseCase.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine

protocol FindLatencyUseCase {
    func execute(hosts: [String]) -> AnyPublisher<(String, Double?), Error>
}

final class FindLatencyUseCaseLive: FindLatencyUseCase {
    private var latencyRepository: LatencyRepository

    init(latencyRepository: LatencyRepository) {
        self.latencyRepository = latencyRepository
    }

    func execute(hosts: [String]) -> AnyPublisher<(String, Double?), Error> {
        return latencyRepository.findHostsLatency(hosts: hosts)
    }
}
