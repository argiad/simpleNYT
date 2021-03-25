//
//  NYTApi.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation

public class NYTApi : NYTApiAction {
    
    // init singelton
    static let shared = NYTApi()
    private init() { }
    
    // callback delegate
    
    private let internalQueue = DispatchQueue(label: "NYTApi",
                                              qos: .default,
                                              attributes: .concurrent)
    
    
    private let requestManager = RequestManager(with: nil)
    
    var delegate: ApiDelegate? {
        get {
            return internalQueue.sync{
                requestManager.delegate
            }
        }
        set {
            internalQueue.async(flags: .barrier) {
                self.requestManager.delegate = newValue
            }
        }
    }
    
    
    func search(by request: String, page: Int = 0) {
        requestManager.search(by: request, page: page)
    }
        
}

