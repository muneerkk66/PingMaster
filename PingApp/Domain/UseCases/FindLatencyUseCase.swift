//
//  FetchAllHostsUseCase.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine

protocol FindLatencyUseCase {
    func execute(hosts: [String]) -> AnyPublisher<LatencyResult, APIError>
}

final class FindLatencyUseCaseLive: FindLatencyUseCase {
    private var latencyRepository: LatencyRepository

    init(latencyRepository: LatencyRepository) {
        self.latencyRepository = latencyRepository
    }

    func execute(hosts: [String]) -> AnyPublisher<LatencyResult, APIError> {
        return latencyRepository.findHostsLatency(hosts: hosts)
    }
}
