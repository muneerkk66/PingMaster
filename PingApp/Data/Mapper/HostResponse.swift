//
//  HostsResponse.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import Foundation

struct HostResponseModel: Decodable {
	let name: String
	let url: String
	let icon: URL

	enum CodingKeys: String, CodingKey {
		case name, url, icon
	}
}
