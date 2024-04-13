//
//  HomeView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = Resolver.shared.resolve(HomeViewModel.self)
    var body: some View {
        List(viewModel.latencyResults, id: \.host) { latency in
            HostView(latency: latency)
        }.onAppear {
            viewModel.handle(.loadAllHosts)
        }
    }
}

#Preview {
    HomeView()
}
