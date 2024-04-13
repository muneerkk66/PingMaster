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
    private var disposables = Set<AnyCancellable>()
    private var hostResults: [HostResponse] = []

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
        case .onTapItem(let latency):
            coordinator.showDetailView(latency: latency)
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
        viewState = .isLoading
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
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                let imageUrl = hostResults.first {$0.url == result.host}?.icon
                let latency = LatencyResult(host: result.host, latency: result.latency, imageUrl: imageUrl)
                latencyResults.append(latency)
            })
            .store(in: &disposables)
    }

}
