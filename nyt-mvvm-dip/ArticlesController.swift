//
//  ArticleController.swift
//  nyt-mvvm-dip
//
//  Created by Artem Mkrtchyan on 3/26/21.
//

import UIKit
import Combine

class ArticlesController: UITableViewController {

    let viewModel = try! DependencyObject.shared.container.resolve() as ViewModel
    
    private var selectedIndex: IndexPath? = nil
    private var subscriber: AnyCancellable?
    
    private var items: [Item] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // MARK: SearchBar init
        navigationItem.titleView = searchBar
        //        searchBar.delegate = self // Live search leads to the 429 response error
        
        // MARK: TableView init
        tableView.dataSource = self
        tableView.delegate = self
        
        // MARK: Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl!)  // bad practice
    }
    
    @objc func refresh(_ sender: AnyObject) {
        searchBar.searchTextField.text = ""
        items.removeAll()
        tableView.reloadData()
        viewModel.fetchArticles(request: "")
        searchBar.endEditing(true)
        refreshControl?.endRefreshing()
        tableView.setNeedsFocusUpdate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailController,
           let row = selectedIndex?.row {
            vc.item = items[row]
        } else {
            selectedIndex = nil
        }
        
        
    }
    
    private func setup(){
        subscriber = viewModel.itemsSubject.sink {(resultComplition) in
            switch resultComplition {
            case .failure(let e):
                DispatchQueue.main.async { [weak self] in
                    self?.error(e: e)
                }
            default:
                break
            }
        } receiveValue: { (items) in
            DispatchQueue.main.async { [weak self] in
                self?.items.append(contentsOf: items)
                self?.tableView.reloadData()
            }
        }
        
    }
    
}

extension ArticlesController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        
        cell.articleImage.image = item.image
        
        if let url = item.imageURL {
            ImageCache.publicCache.load(url: url , item: item) { [weak self] (fetchedItem, image) in
                if let img = image, img != fetchedItem.image, let self = self {
                    
                    if let index = self.items.firstIndex(of: fetchedItem){
                        let path = IndexPath(row: index, section: 0)
                        self.items.first(where: { $0.article._id == fetchedItem.article._id })?.image = img
                        self.tableView.reloadRows(at: [path], with: .fade)
                    }
                }
            }
        }
        
        return cell
    }
    
    func error(e: Error) {
        let alert = UIAlertController(title: "Something went wrong", message:e.localizedDescription , preferredStyle: .alert)
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
}

extension ArticlesController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let left = items.count - indexPath.row
        if left < 2, let text = searchBar.text {
            print("\(indexPath), \(left), \(text)")
            viewModel.fetchArticles(request: text, page: items.count / 10)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndex = nil
    }
}

class MyCell: UITableViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
}

