//
//  HostView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI
import NukeUI

struct HostView: View {
    var showRetry: Bool
    var latency: LatencyResult
    let onTapItem: () -> Void
    var body: some View {
        HStack {
            if showRetry {
                Image(systemName: "arrow.down.circle.dotted")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25) // Adjust size as needed
                    .foregroundColor(.blue)

            }

            LazyImage(url: URL(string: latency.imageUrl ?? ""))
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            Text(latency.name)
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            LatencyView(latency: latency)

        }.animation(.bouncy, value: showRetry)
        .onTapGesture {
            onTapItem()
        }

    }
}

#Preview {
    HostView(showRetry: false, latency: LatencyResult(name: "", host: "", latency: 1.0, imageUrl: ""), onTapItem: {})
}
