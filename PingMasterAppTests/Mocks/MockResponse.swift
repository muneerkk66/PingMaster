//
//  MockResponse.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import Foundation
@testable import PingMaster
struct MockResponse {
    static let hostResponse = HostResponse(name: "name", url: "www.google.com", icon: "")
    static let latencyResponse = ("www.google.com", 0.001)
    static let latencyResult = LatencyResult(name: "name", host: "www.google.com", latency: 1.0, imageUrl: "")

}
