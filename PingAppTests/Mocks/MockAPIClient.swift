//
//  MockAPIClient.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import Foundation
import Combine
@testable import PingApp
import Network

// Mock class to replace the actual implementation of APIClient
import Combine
class MockAPIClient: APIClient {
	let result: Result<Data, APIError>

	init(result: Result<Data, APIError>) {
		self.result = result
	}

	func request<Response>(_ request: APIRequest<Response>) -> AnyPublisher<Response, APIError> {
		switch result {
		case .success(let data):
			do {
				// Decode data to the expected response type and return a publisher with the response
				let response = try JSONDecoder().decode(Response.self, from: data)
				return Just(response)
					.setFailureType(to: APIError.self)
					.eraseToAnyPublisher()
			} catch {
				// If decoding fails, return a publisher with an APIError
				return Fail(error: APIError.serverError(error))
					.eraseToAnyPublisher()
			}
		case .failure(let error):
			// Return a publisher with an APIError
			return Fail(error: error)
				.eraseToAnyPublisher()
		}
	}
}

extension MockAPIClient {
	static func success<Response>(with response: Response) -> MockAPIClient where Response: Encodable {
		// Encode the given response into data to simulate a successful API response
		do {
			let data = try JSONEncoder().encode(response)
			return MockAPIClient(result: .success(data))
		} catch {
			fatalError("Failed to encode response: \(error)")
		}
	}

	static func failure(error: APIError) -> MockAPIClient {
		return MockAPIClient(result: .failure(error))
	}
}
