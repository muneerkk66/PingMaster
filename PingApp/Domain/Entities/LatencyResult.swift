//
//  LatencyResult.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

struct LatencyResult {
    let name: String
    let host: String
    var latency: Double
    let imageUrl: String?
}

extension LatencyResult {
    var latencyValueInMS: String {
        // If host is not reachable
        if latency == Double.greatestFiniteMagnitude {
            return NSLocalizedString("host.latencyError", comment: "Latency error")
        }
        // Converting into ms
        let value = latency * 1000
        return "\(value.formattedLatency ?? "0") ms"
    }
}
