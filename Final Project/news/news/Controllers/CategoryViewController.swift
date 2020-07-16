//
//  CategoryViewController.swift
//  news
//
//  Created by Admin on 7/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var categoryArticlesTable: UITableView!
    
    var barColor: UIColor?
    var category: String?
    
    let categoryArticlesViewModel = CategoryArticlesViewModel()
    
    var categoryArticles = [Article]()
    
    var selectedArticle: Article?
    
    var currentPage = 0
    
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarView.layer.backgroundColor = barColor?.cgColor
        
        topBarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        topBarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        topBarView.layer.shadowRadius = 6
        topBarView.layer.shadowOpacity = 1
        
        categoryName.text = category?.uppercased()
        categoryName.textColor = .white
        
        let backBtnIcon = backBtn.imageView?.image?.withRenderingMode(.alwaysTemplate)
        
        backBtn.imageView?.tintColor = .white
        backBtn.setImage(backBtnIcon, for: .normal)
        
        categoryArticlesTable.delegate = self
        categoryArticlesTable.dataSource = self
        
        categoryArticlesTable.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 20,right: 0)
        
        categoryArticlesTable.register(UINib(nibName: "CategoryArticleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CategoryArticleTableViewCell.identifier)
        
        categoryArticlesTable.register(UINib(nibName: "CategoryArticlesFooter", bundle: nil), forHeaderFooterViewReuseIdentifier: "category_articles_footer")
        
        loadArticles()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didRecieveLoadAction(with:)),
            name: NSNotification.Name("load_more"),
            object: nil)
    }
    
    @objc func didRecieveLoadAction(with notification: Notification) {
        self.loadArticles()
    }
    
    private func loadArticles() {
        self.currentPage += 1
        categoryArticlesViewModel.fetch(category ?? "general", currentPage) { (articleResponse) in
            self.categoryArticles.append(contentsOf: articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" })
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, animations: {
                    self.categoryArticlesTable.alpha = 0
                }) { (f) in
                    
                    self.categoryArticlesTable.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
                    UIView.animate(withDuration: 0.5, animations: {
                        self.categoryArticlesTable.alpha = 1
                    }) { (f) in
                        
                    }
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_category_article_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
                detailsVC.selectedColor = barColor
            }
        }
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArticle = categoryArticles[indexPath.row]
        performSegue(withIdentifier: "show_category_article_details", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return categoryArticles.count > 10 ? categoryArticles.count : 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryArticlesTable.dequeueReusableCell(withIdentifier: "category_article_cell", for: indexPath) as! CategoryArticleTableViewCell
        cell.isLoading(isLoading)
        
        if categoryArticles.count > 10 {
            
            cell.configure(photo: categoryArticles[indexPath.row].image!, title: categoryArticles[indexPath.row].title!, source: categoryArticles[indexPath.row].source.name!, date: categoryArticles[indexPath.row].date!) {
                cell.isLoading(false)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 70: 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = self.categoryArticlesTable.dequeueReusableHeaderFooterView(withIdentifier: "category_articles_footer") as! CategoryArticlesFooter
        
        footer.loadMoreBtn.backgroundColor = barColor
        
        return section == 1 ? footer : UIView()
    }
}

