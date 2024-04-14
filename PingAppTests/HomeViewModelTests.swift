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
		XCTAssertEqual(viewModel.latencyResults.count,0)
	}

	func testRetry() throws {
		let exp = XCTestExpectation(description: "TestRetryLoadLatency")
		XCTAssertEqual(viewModel.latencyResults.count,0)
		viewModel.handle(.retryLoadAllHosts)
		let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
		if result == XCTWaiter.Result.timedOut {
			let results = try XCTUnwrap(viewModel.latencyResults)
			XCTAssertNotNil(results)

		} else {
			XCTFail("Test Failed: RetryLoadLatency")
		}

	}

	func testFetchLatencySuccess() throws {
		let exp = XCTestExpectation(description: "TestFetchLatencySuccess")
		viewModel.fetchAllHostsData()
		let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
		if result == XCTWaiter.Result.timedOut {
			let latency = try XCTUnwrap(viewModel.latencyResults)
			XCTAssertNotNil(latency)

		} else {
			XCTFail("Test Failed: FetchLatency Success")
		}
	}

	func testFetchLatencyFailure() throws {
		let exp = XCTestExpectation(description: "TestFetchLatencyFailure")
		viewModel = HomeViewModel(coordinator: MockHomeCoordinator(), fetchHostsUseCase: MockFetchAllHostsUseCase.failure(error: APIError.applicationError), findLatencyUseCase: MockFindLatencyUseCase.failure(error: APIError.applicationError))

		viewModel.fetchAllHostsData()
		let result = XCTWaiter.wait(for: [exp], timeout: 0.5)
		if result == XCTWaiter.Result.timedOut {
			XCTAssertEqual(viewModel.latencyResults.count,0)
		} else {
			XCTFail("Test Failed: FetchLatency Failure")
		}
	}

}
