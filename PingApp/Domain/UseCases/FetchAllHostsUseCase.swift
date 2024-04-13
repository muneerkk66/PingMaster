//
//  FetchAllHostsUseCase.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine

protocol FetchAllHostsUseCase {
    func execute() -> AnyPublisher<[HostResponse], APIError>
}

final class FetchAllHostsUseCaseLive: FetchAllHostsUseCase {
    private var hostRepository: HostRepository

    init(hostRepository: HostRepository) {
        self.hostRepository = hostRepository
    }

    func execute() -> AnyPublisher<[HostResponse], APIError> {
        return hostRepository.loadAllHosts()
    }
}
