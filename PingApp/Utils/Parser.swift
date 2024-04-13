//
//  Parser.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
    return Just(data)
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error in
            // Handle decoding errors
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case let .typeMismatch(_, context):
                    LogDebug("Type mismatch. Found: %@ for key %@", file: context.codingPath.map({ $0.stringValue }).joined(separator: "."))
                case let .keyNotFound(_, context):
                    LogDebug("Key not found: %@", file: context.codingPath.map({ $0.stringValue }).joined(separator: "."))
                case let .dataCorrupted(context):
                    LogDebug("Data corrupted: %@ for key %@", file: context.debugDescription, function: context.codingPath.map({ $0.stringValue }).joined(separator: "."))
                default: break
                }
                return APIError.serverError(decodingError)
            } else {
                return APIError.serverError(error)
            }
        }
        .eraseToAnyPublisher()
}
