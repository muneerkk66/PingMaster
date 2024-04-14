//
//  LatencyView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

struct LatencyView: View {
    var latency: LatencyResult
    var body: some View {
        HStack {
            Text(latency.latencyValueInMS)
                .font(.caption)
                .foregroundColor(.gray)
            Circle().frame(width: 10, height: 10)
                .foregroundColor( latency.latency != Double.greatestFiniteMagnitude ? .green : .red)
        }
    }
}

#Preview {
    LatencyView(latency: LatencyResult(name: "", host: "", latency: 1.0, imageUrl: ""))
}
