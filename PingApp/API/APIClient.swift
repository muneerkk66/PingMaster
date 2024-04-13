//
//  APIClient.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
import Combine

protocol APIClient {
	@discardableResult
	func request<Response: Decodable>(_ request: APIRequest<Response>) -> AnyPublisher<Response, APIError>
}
