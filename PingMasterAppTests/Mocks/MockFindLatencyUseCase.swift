//
//  MockFetchHostsUseCase.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import Foundation
@testable import PingMaster
import Combine

// Mock FindLatencyUseCase for testing
class MockFindLatencyUseCase: FindLatencyUseCase {

    let result: Result<(String, Double?), Error>

    init(result: Result<(String, Double?), Error>) {
        self.result = result
    }

    func execute(hosts: [String]) -> AnyPublisher<(String, Double?), Error> {
        return result.publisher.eraseToAnyPublisher()
    }
}

extension MockFindLatencyUseCase {
    static func success(with result: (String, Double?)) -> MockFindLatencyUseCase {
        return MockFindLatencyUseCase(result: .success(result))
    }

    static func failure(error: Error) -> MockFindLatencyUseCase {
        return MockFindLatencyUseCase(result: .failure(error))
    }
}
