//
//  LatencyService+Live.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine
import NetworkPinger

final class LatencyServiceLive {
    private var pinger: NetworkPinger

    init(pinger: NetworkPinger) {
        self.pinger = pinger
    }
}

extension LatencyServiceLive: LatencyService {
    func findLatency(hosts: [String]
    ) -> AnyPublisher<(String, Double?), Error> {
        return pinger.ping(hosts: hosts, count: AppConstants.pingCount)
    }
}
