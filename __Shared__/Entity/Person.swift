//
//  Person.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation
struct Person : Codable {
	let firstname : String?
	let middlename : String?
	let lastname : String?
	let qualifier : String?
	let title : String?
	let role : String?
	let organization : String?
	let rank : Int?

	enum CodingKeys: String, CodingKey {

		case firstname = "firstname"
		case middlename = "middlename"
		case lastname = "lastname"
		case qualifier = "qualifier"
		case title = "title"
		case role = "role"
		case organization = "organization"
		case rank = "rank"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		firstname = try values.decodeIfPresent(String.self, forKey: .firstname)
		middlename = try values.decodeIfPresent(String.self, forKey: .middlename)
		lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
		qualifier = try values.decodeIfPresent(String.self, forKey: .qualifier)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		role = try values.decodeIfPresent(String.self, forKey: .role)
		organization = try values.decodeIfPresent(String.self, forKey: .organization)
		rank = try values.decodeIfPresent(Int.self, forKey: .rank)
	}

}
