//
//  ViewController+ApiDelegate.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/24/21.
//

import UIKit

extension ArticlesController: ApiDelegate {
    
    func error(e: MyError) {
        let alert = UIAlertController(title: "Something went wrong", message:e.errorMessage , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                alert.dismiss(animated: true, completion: nil)
            default:
                return
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func resultReceived(response: MyResponse) {
        print(" Meta \(response.response!.meta!)")
        let offset = response.response?.meta?.offset ?? 0 // bad solution
        if let docs = response.response?.docs, objectsList.count == offset {
            if docs.count > 0 {
                docs.forEach { objectsList.append(Item($0)) }
                tableView.reloadData()
                
            } else {
                let alert = UIAlertController(title: "Something went wrong", message: "No results found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        alert.dismiss(animated: true, completion: nil)
                    default:
                        return
                    }
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
}
