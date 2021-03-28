//
//  Network.swift
//  nyt-mvvm-dip
//
//  Created by Artem Mkrtchyan on 3/26/21.
//

import Foundation
import Combine

protocol ApiClient {
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

class MvvmApi: ApiClient {
    
    private var subscribers = Set<AnyCancellable>()
    
    func fetch<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .print()
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            }, receiveValue: { (resultArray) in
                print(resultArray)
                completion(.success(resultArray))
            }).store(in: &subscribers)
    }
}

enum Route {
    case search
    
    var url: String {
        switch self {
        case .search:
            return ApiConstants.apiPath + "search/v2/articlesearch" + ApiConstants.requestType
        }
    }
}
