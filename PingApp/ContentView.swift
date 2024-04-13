//
//  ContentView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI
import Combine
import NetworkPinger

struct ContentView: View {
    var body: some View {
        VStack {
            PingView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct PingView: View {
    @State private var results: [String] = []
    @State private var cancellables = Set<AnyCancellable>()

    // Create the ping service with a specific configuration
    private let networkPingService = NetworkPinger()
    var body: some View {
        List(results, id: \.self) { result in
            Text(result)
        }
        .onAppear {
            pingHosts()
        }
    }

    private func pingHosts() {
        // Define the hosts you want to ping
        let hosts = ["www.ebay.co.uk", "www.ebay.com"]

        // Use the ping service to ping the hosts and handle results
        networkPingService.ping(hosts: hosts, count: 5)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // All pings completed
                    print("Completed pinging all IPs.")
                case .failure(let error):
                    // Handle errors
                    results.append("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { (host, averageLatency) in
                if let latency = averageLatency {
                    results.append("Average latency for \(host): \(latency * 1000) ms")
                } else {
                    results.append("Failed to get latency for \(host)")
                }
            })
            .store(in: &cancellables)
    }
}
