//
//  Keywords.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation
struct Keywords : Codable {
	let name : String?
	let value : String?
	let rank : Int?
	let major : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case value = "value"
		case rank = "rank"
		case major = "major"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		value = try values.decodeIfPresent(String.self, forKey: .value)
		rank = try values.decodeIfPresent(Int.self, forKey: .rank)
		major = try values.decodeIfPresent(String.self, forKey: .major)
	}

}
