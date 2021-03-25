//
//  Response.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation

struct Response: Codable {
    // "status\":\"OK\",\"copyright\":\"Copyright (c) 2021 The New York Times Company. All Rights Reserved.\",\"response\":
    let status: String?
    let copyright: String?
    let response: DocResponse?
}

struct Meta: Codable {
    let hits: Int?
    let offset: Int?
    let time: Int?
}

struct DocResponse: Codable {
    let docs: [Article]?
    let meta: Meta?
}
