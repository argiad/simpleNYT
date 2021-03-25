//
//  Headline.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation
struct Headline : Codable {
	let main : String?
	let kicker : String?
	let content_kicker : String?
	let print_headline : String?
	let name : String?
	let seo : String?
	let sub : String?

	enum CodingKeys: String, CodingKey {

		case main = "main"
		case kicker = "kicker"
		case content_kicker = "content_kicker"
		case print_headline = "print_headline"
		case name = "name"
		case seo = "seo"
		case sub = "sub"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		main = try values.decodeIfPresent(String.self, forKey: .main)
		kicker = try values.decodeIfPresent(String.self, forKey: .kicker)
		content_kicker = try values.decodeIfPresent(String.self, forKey: .content_kicker)
		print_headline = try values.decodeIfPresent(String.self, forKey: .print_headline)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		seo = try values.decodeIfPresent(String.self, forKey: .seo)
		sub = try values.decodeIfPresent(String.self, forKey: .sub)
	}

}
