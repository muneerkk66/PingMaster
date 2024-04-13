//
//  HostListView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

struct HostListView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        List(viewModel.latencyResults, id: \.host) { latency in
            HostView(showRetry: viewModel.showRetry, latency: latency, onTapItem: {
                viewModel.handle(.onTapItem(latency.host))
            })
        }
    }
}

#Preview {
    HostListView()
}
