//
//  PingAppTests.swift
//  PingAppTests
//
//  Created by Muneer K K on 13/04/2024.
//

import XCTest
import SnapshotTesting
@testable import PingApp

@MainActor
final class PingAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoordinatorView ( ) {
        let contentView = HomeCoordinatorView()
        assertSnapshot(of: contentView.toVC(), as: .image, timeout: 10)
    }

    func testDefaultAppearanceWithSuccess ( ) {
        let contentView = HomeView(viewModel: HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.success(with: [MockResponse.hostResponse]), findLatencyUseCase: MockFindLatencyUseCase.success(with: MockResponse.latencyResponse)))

        assertSnapshot(of: contentView.toVC(), as: .image, timeout: 10)
    }

    func testDefaultAppearanceWithError ( ) {
        let contentView = HomeView(viewModel: HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.failure(error: APIError.applicationError), findLatencyUseCase: MockFindLatencyUseCase.failure(error: APIError.applicationError)))

        assertSnapshot(of: contentView.toVC(), as: .image, timeout: 10)
    }

    func testDetailView ( ) {
        let contentView = DetailView(latency: "Test")
        assertSnapshot(of: contentView.toVC(), as: .image, timeout: 10)
    }
    func testErroView() {
        let errorView = ErrorView(errorMessage: "error") {}
        assertSnapshot(of: errorView.toVC(), as: .image, timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
