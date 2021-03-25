//
//  DetailController.swift
//  nyt-mvvm
//
//  Created by Artem Mkrtchyan on 3/25/21.
//

import UIKit

class DetailController: UIViewController {
    
    var item: Item? = nil
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var text: UITextView!
    
    @IBAction func share(_ sender: Any) {
        let message = "NYT Article"
        if let url = item?.article.web_url,  let link = URL(string: url) {
            let objectsToShare :[Any] = [message, link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .addToReadingList]
            self.present(activityVC, animated: true, completion:  nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        image.image = item?.image
        header.text = item?.article.headline?.main
        text.text = item?.article.lead_paragraph
        
    }
}
