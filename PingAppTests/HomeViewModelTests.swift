//
//  HomeViewModelTests.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import XCTest
import Foundation
@testable import PingApp

@MainActor
class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockFetchHostUseCase: MockFetchAllHostsUseCase!
    var mockFindLatencyUseCase: MockFindLatencyUseCase!

    override func setUp() {
        super.setUp()

        viewModel = HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.success(with: [MockResponse.hostResponse]), findLatencyUseCase: MockFindLatencyUseCase.success(with: MockResponse.latencyResponse))

    }

    override func tearDown() {
        viewModel = nil
        mockFetchHostUseCase = nil
        mockFindLatencyUseCase = nil
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(viewModel.viewState, .idle)
        XCTAssertTrue(viewModel.isAscending)
        XCTAssertEqual(viewModel.latencyResults.count, 0)
    }

    func testSortState() {
        XCTAssertTrue(viewModel.isAscending)
        viewModel.handle(.onTapSorting)
        XCTAssertTrue(!viewModel.isAscending)
    }

    func testShowRetry() {
        XCTAssertTrue(!viewModel.showRetry)
        viewModel.handle(.onTapShowRetry)
        XCTAssertTrue(viewModel.showRetry)
    }

    func testRetryLoadAllLatency() throws {
        viewModel = HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.success(with: [MockResponse.hostResponse]), findLatencyUseCase: MockFindLatencyUseCase.success(with: MockResponse.latencyResponse))

        let exp = XCTestExpectation(description: "TestRetryLoadAllLatency")
        XCTAssertEqual(viewModel.latencyResults.count, 0)
        viewModel.handle(.retryLoadAllHosts)
        XCTAssertEqual(viewModel.viewState, HomeViewState.isLoading)
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.viewState, HomeViewState.finished)
            let results = try XCTUnwrap(viewModel.latencyResults)
            XCTAssertNotNil(results)

        } else {
            XCTFail("Test Failed: RetryLoadAllLatency")
        }

    }

    func testRetrySingleLatency() throws {
        let exp = XCTestExpectation(description: "TestRetrySingleLatency")
        viewModel.fetchAllHostsData()
        XCTAssertEqual(viewModel.viewState, HomeViewState.isLoading)
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.viewState, HomeViewState.finished)
            let hosts = try XCTUnwrap(viewModel.hostResults)
            XCTAssertTrue(hosts.count > 0)
            viewModel.handle(.onTapItem(try XCTUnwrap(hosts.first?.url)))
            let latency = try XCTUnwrap(viewModel.latencyResults.first?.latency)
            XCTAssertGreaterThan(latency, 0)

        } else {
            XCTFail("Test Failed: RetrySingleLatency Success")
        }

    }

    func testFetchLatencyResultsSuccess() throws {
        let exp = XCTestExpectation(description: "TestFetchLatencyResultsSuccess")
        viewModel.fetchAllHostsData()
        XCTAssertEqual(viewModel.viewState, HomeViewState.isLoading)
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.viewState, HomeViewState.finished)
            let hosts = try XCTUnwrap(viewModel.hostResults)
            XCTAssertTrue(hosts.count > 0)
            let latency = try XCTUnwrap(viewModel.latencyResults)
            XCTAssertNotNil(latency)

        } else {
            XCTFail("Test Failed: FetchLatencyResults Success")
        }
    }

    func testFetchLatencyResultsFailure() throws {
        let exp = XCTestExpectation(description: "TestFetchLatencyResultsFailure")
        viewModel = HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.failure(error: APIError.applicationError), findLatencyUseCase: MockFindLatencyUseCase.failure(error: APIError.applicationError))

        viewModel.fetchAllHostsData()
        XCTAssertEqual(viewModel.viewState, HomeViewState.isLoading)

        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.viewState, HomeViewState.error(APIError.applicationError.localizedDescription))
            XCTAssertEqual(viewModel.latencyResults.count, 0)
        } else {
            XCTFail("Test Failed: FetchLatencyResults Failure")
        }
    }

    func testFetchLatencyFailure() throws {
        let exp = XCTestExpectation(description: "TestFetchLatencyFailure")
        viewModel = HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.success(with: [MockResponse.hostResponse]), findLatencyUseCase: MockFindLatencyUseCase.failure(error: APIError.applicationError))

        viewModel.fetchAllHostsData()
        let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertEqual(viewModel.latencyResults.count, 0)
        } else {
            XCTFail("Test Failed: FetchLatency Failure")
        }
    }

}
