//
//  FetchAllHostsUseCase.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine

protocol SortLatencyListUseCase {
    func execute(results: [LatencyResult], isAscending: Bool ) -> [LatencyResult]
}

final class SortLatencyListUseCaseLive: SortLatencyListUseCase {

    func execute(results: [LatencyResult], isAscending: Bool ) -> [LatencyResult] {
        return results.sorted { first, second in
            // Treat greatestFiniteMagnitude latency as the largest possible value so it sorts last
            if first.latency == Double.greatestFiniteMagnitude {
                return false
            } else if second.latency == Double.greatestFiniteMagnitude {
                return true
            } else if isAscending {
                return first.latency < second.latency
            } else {
                return first.latency > second.latency
            }
        }
    }
}
