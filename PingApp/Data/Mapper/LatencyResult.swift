//
//  LatencyResult.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

struct LatencyResult {
    let host: String
    let latency: Double
    let imageUrl: String?
}

extension LatencyResult {
    var latencyValue: Double {
        latency * 1000
    }
}
