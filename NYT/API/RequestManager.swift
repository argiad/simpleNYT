//
//  RequestManager.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import Foundation

class RequestManager {
    
    var delegate: ApiDelegate?
    
    init(with delegate: ApiDelegate?) {
        self.delegate = delegate
    }
    
    func search(by request: String, page: Int = 0) {
        if var component = URLComponents(string: ApiConstants.apiPath + Path.search.rawValue + "/v2/" + Action.articlesearch.rawValue + ApiConstants.requestType ){
            component.queryItems = [URLQueryItem(name: "q", value: request),
                                    URLQueryItem(name: "api-key", value: ApiConstants.apiKey),
                                    URLQueryItem(name: "page", value: "\(page)")]
            var urlRequest = URLRequest(url: component.url!)
            urlRequest.httpMethod = "GET"
            print(urlRequest)
            sendRequest(urlRequest){ [weak self] response in
                switch response {
                case .success(let res): self?.delegate?.resultReceived(response: res)
                case .failure(let e): self?.delegate?.error(e: (e as! MyError))
                }
                
            }
            
        }
    }
    
    private func sendRequest(_ urlRequest: URLRequest,  with completion: @escaping (Result<Response, Error>) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = ApiConstants.timeOut
        
        let task = URLSession(configuration: sessionConfig).dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200 ..< 300) ~= response.statusCode,
                  error == nil else {
                completion(.failure(MyError(errorMessage: "Bad status code \((response as? HTTPURLResponse)?.statusCode ?? -1)")))    // need to fix
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(MyError(errorMessage:"JSON decode failure")))
                }
            }
            
        }
        task.resume()
    }
}
