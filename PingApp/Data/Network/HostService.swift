//
//  HostServices.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
import Combine

protocol HostService {
    @discardableResult
    func fetchAllHosts(
    ) -> AnyPublisher<[HostResponse], APIError>
}
