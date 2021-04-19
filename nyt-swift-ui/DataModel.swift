//
//  DataModel.swift
//  nyt-swift-ui
//
//  Created by Artem Mkrtchyan on 4/15/21.
//

import SwiftUI
import Combine

class BusinessLogic: NSObject, ObservableObject {
    
    static let instance = BusinessLogic()
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    var searchString: String = "" { didSet { search() } }
    
    var items : [Item] = [] { didSet { objectWillChange.send() } }
    
    func initFake(){
        items = (load("ArticlesTest.json") as MyResponse).response?.docs?.map { Item($0) } ?? []
    }
    
    private override init(){}
     
    
    private func search(){
        
    }
    
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

}


// var items : [Item] = (load("ArticlesTest.json") as MyResponse).response?.docs?.map { Item($0) } ?? []

