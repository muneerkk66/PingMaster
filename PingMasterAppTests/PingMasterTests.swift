//
//  PingAppTests.swift
//  PingAppTests
//
//  Created by Muneer K K on 13/04/2024.
//

import XCTest
import SnapshotTesting
@testable import PingMaster

@MainActor
final class PingMasterTests: XCTestCase {
    var homeCoordinator: MockHomeCoordinator!
    var sortLatencyListUseCase: SortLatencyListUseCase!

    override func setUpWithError() throws {
        homeCoordinator = MockHomeCoordinator()
        sortLatencyListUseCase = MockSortLatencyListUseCase()
    }

    override func tearDownWithError() throws {
        homeCoordinator = nil
        sortLatencyListUseCase = nil
    }

    func testCoordinatorView ( ) {
        let contentView = HomeCoordinatorView()
        assertSnapshot(of: contentView.toVC(), as: .image, timeout: 10)
    }

    func testDefaultAppearanceWithSuccess ( ) {
        let contentView = HomeView(viewModel: HomeViewModel(coordinator: self.homeCoordinator, fetchHostsUseCase: MockFetchAllHostsUseCase.success(with: [MockResponse.hostResponse]), findLatencyUseCase: MockFindLatencyUseCase.success(with: MockResponse.latencyResponse), sortLatencyListUseCase: self.sortLatencyListUseCase))

        assertSnapshot(of: contentView.toVC(), as: .image, timeout: 10)
    }

    func testDefaultAppearanceWithError ( ) {
        let contentView = HomeView(viewModel: HomeViewModel(coordinator: self.homeCoordinator, fetchHostsUseCase: MockFetchAllHostsUseCase.failure(error: APIError.applicationError), findLatencyUseCase: MockFindLatencyUseCase.failure(error: APIError.applicationError), sortLatencyListUseCase: self.sortLatencyListUseCase))

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
