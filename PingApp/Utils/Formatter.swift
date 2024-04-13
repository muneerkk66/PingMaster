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
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    return formatter
}()

extension Double {
    /// Returns the latency representation of the integer.
    var latency: String? {
        return latencyValueFormatter.string(from: NSNumber(value: self))
    }
}
