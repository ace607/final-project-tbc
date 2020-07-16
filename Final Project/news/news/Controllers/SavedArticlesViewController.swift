//
//  SavedArticlesViewController.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SavedArticlesViewController: UIViewController {
    @IBOutlet weak var savedArticlesTitle: UILabel!
    @IBOutlet weak var savedArticlesTable: UITableView!
    
    var savedTitle: SavedArticles?
    
    var selectedArticle: Article?
    
    private var isLoading = true
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedArticlesTitle.text = savedTitle?.rawValue
        
        savedArticlesTable.delegate = self
        savedArticlesTable.dataSource = self
        
        savedArticlesTable.register(UINib(nibName: "CategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        if savedTitle == .readLater {
            articles = CoreDataManager.fetchReadLater().map { Article(source: ArticleSource(id: "", name: $0.source), author: $0.author, title: $0.title, description: $0.desc, url: $0.url, image: $0.img, date: $0.date, content: $0.content) }
        } else {
            articles = CoreDataManager.fetchRecents().map { Article(source: ArticleSource(id: "", name: $0.source), author: $0.author, title: $0.title, description: $0.desc, url: $0.url, image: $0.img, date: $0.date, content: $0.content) }
            
            articles = articles.count > 20 ? Array(articles[0..<20]) : articles
        }
        
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(didRecieveUpdate(with:)),
        name: NSNotification.Name("update_saved"),
        object: nil)
    }
    
    @objc func didRecieveUpdate(with notification: Notification) {
        articles.removeAll()
        
        if savedTitle == .readLater {
            articles = CoreDataManager.fetchReadLater().map { Article(source: ArticleSource(id: "", name: $0.source), author: $0.author, title: $0.title, description: $0.desc, url: $0.url, image: $0.img, date: $0.date, content: $0.content) }
        } else {
            articles = CoreDataManager.fetchRecents().map { Article(source: ArticleSource(id: "", name: $0.source), author: $0.author, title: $0.title, description: $0.desc, url: $0.url, image: $0.img, date: $0.date, content: $0.content) }
        }

        savedArticlesTable.reloadData()
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "saved_article_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
            }
        }
    }
    
}

extension SavedArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedArticlesTable.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        cell.isLoading(isLoading)
        
        if articles.count > 0 {
            
            cell.configure(photo: articles[indexPath.row].image!, title: articles[indexPath.row].title!, source: articles[indexPath.row].source.name!, date: articles[indexPath.row].date!) {
                cell.isLoading(false)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "saved_article_details", sender: self)
    }
    
    
}
