//
//  HostsRepository.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

final class HostRepositoryLive: HostRepository {

	private let hostService: HostService

	init(hostService: HostService) {
		self.hostService = hostService
	}
