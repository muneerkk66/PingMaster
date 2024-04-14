//
//  MockFetchHostsUseCase.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import Foundation
import Combine

// Mock SortLatencyListUseCase for testing
final class MockSortLatencyListUseCase: SortLatencyListUseCase {
    var lastResults: [LatencyResult]?
    var lastIsAscending: Bool?
    var mockResults: [LatencyResult] = []

    func execute(results: [LatencyResult], isAscending: Bool) -> [LatencyResult] {
        lastResults = results
        lastIsAscending = isAscending
        return mockResults  // Return mock data you can set in test
    }
}
