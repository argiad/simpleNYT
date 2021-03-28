//
//  ViewModel.swift
//  nyt-mvvm-dip
//
//  Created by Artem Mkrtchyan on 3/26/21.
//

import Combine
import Foundation


class ViewModel {
    
    private let apiManager: ApiClient!
    
    var itemsSubject = PassthroughSubject<[Item], Error>()
    
    init(apiManager: ApiClient ) {
        self.apiManager = apiManager
    }
    
    func fetchArticles(request: String , page: Int = 0) {
        if var component = URLComponents(string: Route.search.url ){
            component.queryItems = [URLQueryItem(name: "q", value: request),
                                    URLQueryItem(name: "api-key", value: ApiConstants.apiKey),
                                    URLQueryItem(name: "page", value: "\(page)")]
            var urlRequest = URLRequest(url: component.url!)
            urlRequest.httpMethod = "GET"
            
            apiManager.fetch(urlRequest: urlRequest) { [unowned self] (result: Result<MyResponse, Error>) in
                switch result {
                case .failure(let error):
                    self.itemsSubject.send(completion: .failure(error))
                case .success(let response):
                    print(response)
                    if let docs = response.response?.docs {
                        let items =  docs.map({Item($0)})
                        self.itemsSubject.send(items)
                    }
                }
            }
        }
    }
    
}
