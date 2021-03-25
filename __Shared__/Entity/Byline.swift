//
//  Byline.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation
struct Byline : Codable {
	let original : String?
	let person : [Person]?
	let organization : String?

	enum CodingKeys: String, CodingKey {

		case original = "original"
		case person = "person"
		case organization = "organization"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		original = try values.decodeIfPresent(String.self, forKey: .original)
		person = try values.decodeIfPresent([Person].self, forKey: .person)
		organization = try values.decodeIfPresent(String.self, forKey: .organization)
	}

}
