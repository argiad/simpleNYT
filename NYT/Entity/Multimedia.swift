//
//  Multimedia.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation
struct Multimedia : Codable {
	let rank : Int?
	let subtype : String?
	let caption : String?
	let credit : String?
	let type : String?
	let url : String?
	let height : Int?
	let width : Int?
	let legacy : Legacy?
	let subType : String?
	let crop_name : String?

	enum CodingKeys: String, CodingKey {

		case rank = "rank"
		case subtype = "subtype"
		case caption = "caption"
		case credit = "credit"
		case type = "type"
		case url = "url"
		case height = "height"
		case width = "width"
		case legacy = "legacy"
		case subType = "subType"
		case crop_name = "crop_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rank = try values.decodeIfPresent(Int.self, forKey: .rank)
		subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
		caption = try values.decodeIfPresent(String.self, forKey: .caption)
		credit = try values.decodeIfPresent(String.self, forKey: .credit)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		legacy = try values.decodeIfPresent(Legacy.self, forKey: .legacy)
		subType = try values.decodeIfPresent(String.self, forKey: .subType)
		crop_name = try values.decodeIfPresent(String.self, forKey: .crop_name)
	}

}
