//
//  APIRequest.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

struct APIRequest<Response: Decodable> {
    var path: String
    var query: [String: String]?
    var method: Method = .get
    var headers: [String: String]? = ["Content-Type": "application/json"]
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    enum Method {
        case get
        case post(Data)
        case put(Data)

        var stringValue: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            }
        }
    }
}

extension APIRequest: CustomStringConvertible {
    var description: String {
        """
            Request(
            path: \(path),
            query: \(query ?? [:]),
            method: \(method),
            headers: \(headers?.mapValues { $0.description.localizedCaseInsensitiveContains("Bearer") ? "***" : $0 } ?? [:])
        )
        """
    }
}

extension APIRequest {
    func makeRequest(using environment: AppEnvironment) throws -> URLRequest {
        guard var components = URLComponents(url: environment.baseURL, resolvingAgainstBaseURL: true) else {
            throw URLError(.badURL)
        }
        components.path = path.isEmpty ? "" : components.path + path.replacingOccurrences(of: " ", with: "%20")
        components.queryItems = query?.compactMap { URLQueryItem(name: $0.0, value: $0.1) }

        guard let url = components.url else {
            throw URLError(.unsupportedURL)
        }

        var urlRequest = URLRequest(url: url)
        headers?.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        urlRequest.httpMethod = method.stringValue

        if case let .post(data) = method {
            urlRequest.httpBody = data
        } else if case let .put(data) = method {
            urlRequest.httpBody = data
        }

        headers?.forEach { key, value in
            urlRequest.setValue(value.description, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}
