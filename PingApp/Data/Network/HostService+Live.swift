//
//  HostService+Live.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Combine

final class HostServiceLive {
    private var apiClient: APIClient

    enum Endpoint {
        case fetchAllHosts
        var path: String {
            switch self {
            case .fetchAllHosts:
                return "/anonymous/290132e587b77155eebe44630fcd12cb/raw/"
            }
        }
    }

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

extension HostServiceLive: HostService {
    func fetchAllHosts(
    ) -> AnyPublisher<[HostResponse], APIError> {

        let fetchRequest = APIRequest<[HostResponse]>(
            path: Self.Endpoint.fetchAllHosts.path,
            method: .get
        )
        return apiClient.request(fetchRequest)
    }
}
