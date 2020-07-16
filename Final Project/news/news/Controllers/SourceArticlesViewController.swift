//
//  SourceArticlesViewController.swift
//  news
//
//  Created by Admin on 7/12/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SourceArticlesViewController: UIViewController {
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var sourceCountry: UILabel!
    @IBOutlet weak var sourceArticlesTable: UITableView!
    
    
    var selectedSource: Source?
    var articles = [Article]()
    var selectedArticle: Article?
    
    let sourceArticlesViewModel = SourceArticlesViewModel()
    
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sourceName.text = selectedSource?.name
        sourceCountry.text = selectedSource?.country?.uppercased()
        
        sourceArticlesTable.delegate = self
        sourceArticlesTable.dataSource = self
        
        sourceArticlesTable.register(UINib(nibName: "CategoryArticleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CategoryArticleTableViewCell.identifier)
        
        sourceArticlesViewModel.fetch(selectedSource!.id!) { articleResponse in
            self.articles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            DispatchQueue.main.async {
                self.sourceArticlesTable.reloadData()
            }
        }
    }

    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "source_article_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
            }
        }
    }
}

extension SourceArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = articles[indexPath.row]
        performSegue(withIdentifier: "source_article_details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourceArticlesTable.dequeueReusableCell(withIdentifier: CategoryArticleTableViewCell.identifier, for: indexPath) as! CategoryArticleTableViewCell
        
        cell.isLoading(isLoading)
        
        if articles.count > 0 {
            
            cell.configure(photo: articles[indexPath.row].image!, title: articles[indexPath.row].title!, source: articles[indexPath.row].source.name!, date: articles[indexPath.row].date!) {
                cell.isLoading(false)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
