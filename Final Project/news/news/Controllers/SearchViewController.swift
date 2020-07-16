//
//  SearchViewController.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchField: SearchField!
    @IBOutlet weak var resultsCountLabel: UILabel!
    @IBOutlet weak var searchTable: UITableView!
    
    let searchViewModel = SearchViewModel()
    
    var articles = [Article]()
    var selectedArticle: Article?
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        let searchIcon = UIImageView(image: UIImage(named: "search")?.withRenderingMode(.alwaysTemplate))
        searchIcon.tintColor = Constants.grayText.withAlphaComponent(0.5)
        searchIcon.frame = CGRect(x: rightView.center.x - 12, y: rightView.center.y - 12, width: searchIcon.frame.width, height: searchIcon.frame.height)
        
        rightView.addSubview(searchIcon)
        
        searchTable.register(UINib(nibName: "CategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        searchField.rightViewMode = .always
        searchField.rightView = rightView
        searchField.rightView?.contentMode = .center
        
        searchField.layer.cornerRadius = 25
        
        searchTable.delegate = self
        searchTable.dataSource = self
        
        resultsCountLabel.text = ""
        
        searchTable.alpha = 0
        
    }
    
    func searchForQuery(query: String, completion: @escaping () -> ()) {
        searchViewModel.fetch(query) { articleResponse in
            self.articles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            DispatchQueue.main.async {
                completion()
                self.resultsCountLabel.text = "\(self.articles.count) articles found"
                self.searchTable.reloadData()
            }
        }
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        articles.removeAll()
        searchTable.reloadData()
        UIView.animate(withDuration: 0.6) {
            self.searchTable.alpha = 0
        }
        if sender.text == "" {
            print("clicked")
            resultsCountLabel.text = ""
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.searchForQuery(query: sender.text!.components(separatedBy: " ").joined(separator: "+")) {
                    
                    UIView.animate(withDuration: 0.6) {
                        self.searchTable.alpha = self.articles.count == 0 ? 0 : 1
                    }
                }
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_search_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "show_search_details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTable.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.isLoading(isLoading)
        
        if articles.count > 5 {
            
            cell.configure(photo: articles[indexPath.row].image ?? "", title: articles[indexPath.row].title ?? "", source: articles[indexPath.row].source.name ?? "", date: articles[indexPath.row].date ?? "") {
                cell.isLoading(false)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
