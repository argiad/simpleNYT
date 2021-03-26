//
//  ViewController.swift
//  NYT
//
//  Created by Artem Mkrtchyan on 3/23/21.
//

import UIKit

class ArticlesController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var tableView: UITableView!
    
    var objectsList = [Item]()
    var dataSource: UITableViewDiffableDataSource<Int, Item>! = nil
    
//    private var refreshControl = UIRefreshControl()
    var selectedIndex: IndexPath? = nil
    
    @IBAction func searchAction(_ sender: Any) {
        objectsList.removeAll()
        searchBar.endEditing(true)
        NYTApi.shared.search(by: searchBar.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NYTApi.shared.delegate = self
        
        // MARK: SearchBar init
        navigationItem.titleView = searchBar
        //        searchBar.delegate = self // Live search leads to the 429 response error
        
        // MARK: TableView init
//        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        searchBar.searchTextField.text = ""
        NYTApi.shared.search(by: "")
        objectsList.removeAll()
        tableView.reloadData()
        searchBar.endEditing(true)
        refreshControl?.endRefreshing()
        tableView.setNeedsFocusUpdate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailController,
           let row = selectedIndex?.row {
            vc.item = objectsList[row]
        } else {
            selectedIndex = nil
        }
        
        
    }
}
