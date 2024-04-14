//
//  HostServiceTests.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//
import XCTest
import Foundation
@testable import PingApp

final class HostServiceTests: XCTestCase {
    var model: HostServiceLive!
    override func setUpWithError() throws {
		let client = MockAPIClient.success(with: [MockResponse.hostResponse])
		model = HostServiceLive(apiClient: client)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchAlHosts() throws {
        let result = try awaitPublisher(model.fetchAllHosts())
        XCTAssertTrue(try XCTUnwrap(result.count) > 0)
		XCTAssertNotNil(try XCTUnwrap(result.first).url)
		XCTAssertNotNil(try XCTUnwrap(result.first).icon)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
