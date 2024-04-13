//
//  HomeViewState.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

enum HomeViewEvent {
    case onTapItem(String)
    case retryLoadAllHosts
    case loadAllHosts
}

enum HomeViewState: Comparable {
    case idle
    case isLoading
    case finished
    case error(String)
}
