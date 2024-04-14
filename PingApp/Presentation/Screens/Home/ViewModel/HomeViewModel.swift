//
//  HomeViewModel.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    private let fetchHostsUseCase: FetchAllHostsUseCase
    private let findLatencyUseCase: FindLatencyUseCase

    @Published var latencyResults: [LatencyResult] = []
    @Published var viewState: HomeViewState = .idle
    @Published var showRetry: Bool = false
    private(set) var isAscending = true
    private(set) var hostResults: [HostResponse] = []
    private var disposables = Set<AnyCancellable>()

    init(coordinator: HomeCoordinatorProtocol, fetchHostsUseCase: FetchAllHostsUseCase, findLatencyUseCase: FindLatencyUseCase) {
        self.coordinator = coordinator
        self.fetchHostsUseCase = fetchHostsUseCase
        self.findLatencyUseCase = findLatencyUseCase
    }

    @MainActor
    func handle(_ event: HomeViewEvent) {
        switch event {
        case .loadAllHosts, .retryLoadAllHosts:
            fetchAllHostsData()
        case .onTapItem(let host):
            if showRetry {
                findLatency(hosts: [host])
            } else {
                coordinator.showDetailView(host: host)
                showRetry = false
            }
        case .onTapSorting:
            isAscending.toggle()
            sortResult()
        case .onRetryHost(let host):
            findLatency(hosts: [host])
        case .onTapShowRetry:
            showRetry.toggle()
        }
    }

    func fetchAllHostsData() {
        viewState = .isLoading
        fetchHostsUseCase
            .execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    viewState = .error(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] results in
                guard let self = self else { return }
                hostResults = results
                latencyResults = []
                findLatency(hosts: hostResults.map {$0.url})
            })
            .store(in: &disposables)
    }

    func findLatency(hosts: [String]) {
        findLatencyUseCase.execute(hosts: hosts)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(let error):
                    viewState = .error(error.localizedDescription)
                    break
                case .finished:
                    viewState = .finished
                    break
                }
            }, receiveValue: { [weak self] (host, latency) in
                guard let self = self else { return }
                if let index = self.latencyResults.firstIndex(where: { $0.host == host }) {
                    // Host exists, update latency
                    self.latencyResults[index].latency = latency ?? Double.greatestFiniteMagnitude
                } else {
                    // Host does not exist, add new LatencyResult
                    if let hostResult = self.hostResults.first(where: { $0.url == host }) {
                        let newLatencyResult = LatencyResult(name: hostResult.name, host: host, latency: latency ?? Double.greatestFiniteMagnitude, imageUrl: hostResult.icon)
                        self.latencyResults.append(newLatencyResult)
                    }
                }
                self.sortResult()

            })
            .store(in: &disposables)
    }

    func sortResult() {
        latencyResults = latencyResults.sorted { first, second in
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
