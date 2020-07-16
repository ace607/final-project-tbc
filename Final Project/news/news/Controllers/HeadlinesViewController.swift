//
//  HeadlinesViewController.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class HeadlinesViewController: UIViewController {

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var headLinesSwiper: VerticalCardSwiper!
    
    var articles = [Article]()
    
    let headlinesViewModel = HeadlinesViewModel()
    
    var selectedArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headLinesSwiper.delegate = self
        headLinesSwiper.datasource = self
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        let current = formatter.string(from: now)
        
        currentDate.text = current
        
        headLinesSwiper.register(nib: UINib(nibName: "HeadlineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HeadlineCollectionViewCell.identifier)
        
        headlinesViewModel.fetch { response in
            self.articles = response.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            DispatchQueue.main.async {
                self.headLinesSwiper.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_headline_article" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
            }
        }
    }

}

extension HeadlinesViewController: VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return articles.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        let cell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: HeadlineCollectionViewCell.identifier, for: index) as! HeadlineCollectionViewCell
        
        
        cell.configure(article: articles[index])
        
        
        return cell
    }
    
    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        selectedArticle = articles[index]
        performSegue(withIdentifier: "show_headline_article", sender: self)
    }
    
    
}
