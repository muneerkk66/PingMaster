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
        sceneView.onAppear {
            viewModel.handle(.loadAllHosts)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.handle(.onTapSorting)
                } label: {
                    Image(systemName: "arrow.up.arrow.down").resizable() .foregroundColor(.blue).frame(width: 20, height: 20)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.handle(.onTapShowRetry)
                } label: {
                    Image(systemName: "goforward").resizable() .foregroundColor(.blue).frame(width: 20, height: 20)
                }
            }
        }
        .environmentObject(viewModel)
    }

    @ViewBuilder
    private var sceneView: some View {
        switch viewModel.viewState {
        case .finished:
            HostListView()
        case .isLoading, .idle:
            ProgressView()
        case .error(let error):
            ErrorView(errorMessage: error) {
                viewModel.handle(.retryLoadAllHosts)
            }
        }
    }
}

#Preview {
    HomeView()
}
