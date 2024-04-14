//
//  Formatter.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

private var latencyValueFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 3
    formatter.minimumFractionDigits = 3
    formatter.roundingMode = .halfUp
    return formatter
}()

extension Double {
    /// Returns the latency representation of the integer.
    var formattedLatency: String? {
        return latencyValueFormatter.string(from: NSNumber(value: self))
    }
}
