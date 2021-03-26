//
//  ViewController+UITableView.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import UIKit


extension ArticlesController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        
        let item = objectsList[indexPath.row]
        
        cell.articleImage.image = item.image
        
        if let url = item.imageURL {
            ImageCache.publicCache.load(url: url , item: item) { [weak self] (fetchedItem, image) in
                if let img = image, img != fetchedItem.image, let self = self {
                    
                    if let index = self.objectsList.firstIndex(of: fetchedItem){
                        let path = IndexPath(row: index, section: 0)
                        self.objectsList.first(where: { $0.article._id == fetchedItem.article._id })?.image = img
                        self.tableView.reloadRows(at: [path], with: .fade)
                    }
                }
            }
        }
        
        return cell
    }
    
    
}

extension ArticlesController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left = objectsList.count - indexPath.row
        if left < 2, let text = searchBar.text {
            print("\(indexPath), \(left), \(text)")
            NYTApi.shared.search(by: text, page: objectsList.count / 10)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        selectedIndex = indexPath
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("-didDeselectRowAt")
        selectedIndex = nil
    }
}

class MyCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
}
