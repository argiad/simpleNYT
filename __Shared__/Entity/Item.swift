//
//  Item.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import UIKit

class Item : NSObject {
    
    var image: UIImage?
    var imageURL: NSURL? {
        get {
            guard let urlString = article.multimedia?.first(where: {$0.type == "image" })?.url else {
                return nil
            }
            return NSURL.init(string: "https://static01.nyt.com/" + urlString)
        }
    }
    
    
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
    
}
