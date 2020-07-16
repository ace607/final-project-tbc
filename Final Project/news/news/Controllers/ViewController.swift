//
//  ViewController.swift
//  news
//
//  Created by Admin on 7/2/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var exploreTable: UITableView!
    
    let topNewsViewModel = TopNewsViewModel()
    let categoryNewsViewModel = CategoryNewsViewModel()
    let covidViewModel = CovidViewModel()
    
    var topNews = [Article]()
    var categoryArticlesOne = [Article]()
    var categoryArticlesTwo = [Article]()
    var covidArticles = [Article]()
    var trendingArticles = [Article]()

    var chosenCategories = Constants.categories.shuffled()
    var firstCategory: String?
    var secondCategory: String?
    
    var selectedArticle: Article?
    
    var selectedCategory: String?
    var selectedCategoryColor: UIColor?
    var selectedLogoColor: UIColor?
    
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        exploreTable.delegate = self
        exploreTable.dataSource = self
        
        exploreTable.register(UINib(nibName: "TopNewsContainerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: TopNewsContainerTableViewCell.identifier)
        
        exploreTable.register(UINib(nibName: "CategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        
        exploreTable.register(UINib(nibName: "LargeCategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: LargeCategoryTableViewCell.identifier)
        
        
        exploreTable.register(UINib(nibName: "CategoryListContainerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CategoryListContainerTableViewCell.identifier)
        
        exploreTable.register(UINib(nibName: "CategoryHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "category_header")
        
        
        exploreTable.register(UINib(nibName: "CovidContainerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CovidContainerTableViewCell.identifier)
        
        topNewsViewModel.fetch { (articleResponse) in
            
            let articles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            
            self.topNews = Array(articles[0..<20])
            
            
            if articles.count > 20 {
                self.trendingArticles = Array(articles[20..<(articles.count - 1)])
            }
            
            DispatchQueue.main.async {
                self.exploreTable.reloadData()
            }
        }
        
        for item in chosenCategories {
            if item != "sports" {
                firstCategory = item
                break
            }
        }
        
        categoryNewsViewModel.fetch(firstCategory!) { (articleResponse) in
            
            self.chosenCategories.remove(at: 0)
            
            let validArticles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            
            self.categoryArticlesOne = validArticles.count > 2 ? Array(validArticles.shuffled()[0..<2]) : validArticles
            DispatchQueue.main.async {
                self.exploreTable.reloadData()
            }
        }
        
        
        for item in chosenCategories {
            if item != "sports" && item != firstCategory! {
                secondCategory = item
                break
            }
        }
        
        categoryNewsViewModel.fetch(secondCategory!) {(articleResponse) in
            
            self.chosenCategories.remove(at: 0)
            
            let validArticles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            
            self.categoryArticlesTwo = validArticles.count > 3 ? Array(validArticles.shuffled()[0..<3]) : validArticles
            
            DispatchQueue.main.async {
                self.exploreTable.reloadData()
            }
        }
        
        covidViewModel.fetch { articleResponse in
            self.covidArticles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            DispatchQueue.main.async {
                self.exploreTable.reloadData()
            }
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_article_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
                detailsVC.selectedColor = selectedLogoColor
            }
        }
        
        if let identifier = segue.identifier, identifier == "show_category_articles" {
            if let categoryVC = segue.destination as? CategoryViewController {
                categoryVC.category = selectedCategory
                categoryVC.barColor = selectedCategoryColor
            }
        }
    }
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 3
        case 4:
            return 1
        case 5:
            return trendingArticles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = exploreTable.dequeueReusableCell(withIdentifier: TopNewsContainerTableViewCell.identifier, for: indexPath) as! TopNewsContainerTableViewCell
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM"
            let currentDate = formatter.string(from: now)
            
            cell.currentDateLabel.text = currentDate
            if topNews.count > 0 {
                cell.articles = topNews
            }
            
            cell.didSelectItemAction = { [weak self] article in
                self?.selectedArticle = article
                self?.selectedLogoColor = Constants.purple
                self?.performSegue(withIdentifier: "show_article_details", sender: self)
                
            }
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = exploreTable.dequeueReusableCell(withIdentifier: "category_cell", for: indexPath) as! CategoryTableViewCell
            
            cell.prepareForReuse()
            
            cell.isLoading(isLoading)
            
            if categoryArticlesOne.count > 0 {
                
                cell.configure(photo: categoryArticlesOne[indexPath.row].image!, title: categoryArticlesOne[indexPath.row].title!, source: categoryArticlesOne[indexPath.row].source.name!, date: categoryArticlesOne[indexPath.row].date!) {
                    cell.isLoading(false)
                }
            }
            
            
            cell.selectionStyle = .none
            
            return cell
        case 2:
            let cell = exploreTable.dequeueReusableCell(withIdentifier: "category_list_container_cell", for: indexPath) as! CategoryListContainerTableViewCell
            
            cell.didSelectCategoryAction = { [weak self] (category, color) in
                self?.selectedCategory = category
                self?.selectedCategoryColor = color
                
                self?.performSegue(withIdentifier: "show_category_articles", sender: self)
                
            }
            
            cell.selectionStyle = .none
            
            return cell
        case 3:
            if indexPath.row == 0 {
                let cell = exploreTable.dequeueReusableCell(withIdentifier: "large_category_cell", for: indexPath) as! LargeCategoryTableViewCell
                

                cell.isLoading(isLoading)
                
                if categoryArticlesTwo.count > 0 {
                    
                    cell.configure(photo: categoryArticlesTwo[indexPath.row].image!, title: categoryArticlesTwo[indexPath.row].title!, source: categoryArticlesTwo[indexPath.row].source.name!, date: categoryArticlesTwo[indexPath.row].date!) {
                        cell.isLoading(false)
                    }
                }
                
                
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = exploreTable.dequeueReusableCell(withIdentifier: "category_cell", for: indexPath) as! CategoryTableViewCell
                
                cell.isLoading(isLoading)
                
                if categoryArticlesTwo.count > 0 {
                    
                    cell.configure(photo: categoryArticlesTwo[indexPath.row].image!, title: categoryArticlesTwo[indexPath.row].title!, source: categoryArticlesTwo[indexPath.row].source.name!, date: categoryArticlesTwo[indexPath.row].date!) {
                        cell.isLoading(false)
                    }
                }
                
                
                cell.selectionStyle = .none
                
                return cell
            }
        case 4:
            let cell = exploreTable.dequeueReusableCell(withIdentifier: "covid_cell", for: indexPath) as! CovidContainerTableViewCell
            if covidArticles.count > 0 {
                cell.articles = covidArticles
            }
            
            cell.didSelectItemAction = { [weak self] article in
                self?.selectedArticle = article
                self?.selectedLogoColor = Constants.covidColor
                
                self?.performSegue(withIdentifier: "show_article_details", sender: self)
                
            }
            
            cell.didTapMoreInfo = { [weak self] in
                self?.performSegue(withIdentifier: "show_covid_info", sender: self)
            }
            
            cell.selectionStyle = .none

            return cell
        case 5:
            let cell = exploreTable.dequeueReusableCell(withIdentifier: "large_category_cell", for: indexPath) as! LargeCategoryTableViewCell
            
            cell.isLoading(isLoading)
            
            if trendingArticles.count > 0 {
                
                cell.configure(photo: trendingArticles[indexPath.row].image!, title: trendingArticles[indexPath.row].title!, source: trendingArticles[indexPath.row].source.name!, date: trendingArticles[indexPath.row].date!) {
                    cell.isLoading(false)
                }
            }
            
            cell.selectionStyle = .none
            
            return cell
        default:
            print("")
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 || section == 3 || section == 5 { return 45 }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // Dequeue with the reuse identifier
        let header = self.exploreTable.dequeueReusableHeaderFooterView(withIdentifier: "category_header") as! CategoryHeaderView
        
        if section == 1 {
            
            header.categoryName.text = firstCategory!.uppercased()
            
            return header
        } else if section == 3 {
            header.categoryName.text = secondCategory!.uppercased()
            
            return header
        } else if section == 5 {
            header.categoryName.text = "Trending Stories"
            
            return header
        }
        
        return UIView()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedArticle = categoryArticlesOne[indexPath.row]
            self.selectedLogoColor = Constants.purple
            performSegue(withIdentifier: "show_article_details", sender: self)
        } else if indexPath.section == 3 {
            selectedArticle = categoryArticlesTwo[indexPath.row]
            self.selectedLogoColor = Constants.purple
            performSegue(withIdentifier: "show_article_details", sender: self)
        } else if indexPath.section == 5 {
            selectedArticle = trendingArticles[indexPath.row]
            self.selectedLogoColor = Constants.purple
            performSegue(withIdentifier: "show_article_details", sender: self)
        }
    }
    
}

