//
//  Legacy.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//


import Foundation
struct Legacy : Codable {
	let xlarge : String?
	let xlargewidth : Int?
	let xlargeheight : Int?

	enum CodingKeys: String, CodingKey {

		case xlarge = "xlarge"
		case xlargewidth = "xlargewidth"
		case xlargeheight = "xlargeheight"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		xlarge = try values.decodeIfPresent(String.self, forKey: .xlarge)
		xlargewidth = try values.decodeIfPresent(Int.self, forKey: .xlargewidth)
		xlargeheight = try values.decodeIfPresent(Int.self, forKey: .xlargeheight)
	}

}
