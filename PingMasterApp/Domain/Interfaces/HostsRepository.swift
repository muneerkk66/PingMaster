//
//  HostsRepository.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine

protocol HostRepository {
    func loadAllHosts() -> AnyPublisher<[HostResponse], APIError>
}
