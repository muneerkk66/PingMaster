//
//  HostView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI
import NukeUI

struct HostView: View {
    var latency: LatencyResult
    var body: some View {
        HStack {
            LazyImage(url: URL(string: latency.imageUrl ?? ""))
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text(latency.host)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            LatencyView(latency: latency)
        }

    }
}

#Preview {
    HostView(latency: LatencyResult(host: "", latency: 1.0, imageUrl: ""))
}
