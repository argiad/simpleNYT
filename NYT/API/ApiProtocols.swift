//
//  ApiProtocols.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation

protocol ApiDelegate {
    func resultReceived(response: Response)
    func error(e: MyError)
}

protocol NYTApiAction {
    func search(by request: String, page: Int)
}
