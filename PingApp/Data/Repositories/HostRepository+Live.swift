//
//  HostsRepository.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
import Combine

final class HostRepositoryLive: HostRepository {

    private let hostService: HostService

    init(hostService: HostService) {
        self.hostService = hostService
    }

    func loadAllHosts() -> AnyPublisher<[HostResponse], APIError> {
        guard NetworkMonitor.shared.isConnected else { return Fail(error: APIError.connectionError).eraseToAnyPublisher()}
        return hostService
            .fetchAllHosts()
    }
}
