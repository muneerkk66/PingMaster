//
//  MockFetchHostsUseCase.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import Foundation
@testable import PingMaster
import Combine

// Mock FetchAllHostsUseCase for testing
class MockFetchAllHostsUseCase: FetchAllHostsUseCase {

    let result: Result<[HostResponse], APIError>

    init(result: Result<[HostResponse], APIError>) {
        self.result = result
    }

    func execute() -> AnyPublisher<[HostResponse], APIError> {
        return result.publisher.eraseToAnyPublisher()
    }
}

extension MockFetchAllHostsUseCase {
    static func success(with result: [HostResponse]) -> MockFetchAllHostsUseCase {
        return MockFetchAllHostsUseCase(result: .success(result))
    }

    static func failure(error: APIError) -> MockFetchAllHostsUseCase {
        return MockFetchAllHostsUseCase(result: .failure(error))
    }
}
