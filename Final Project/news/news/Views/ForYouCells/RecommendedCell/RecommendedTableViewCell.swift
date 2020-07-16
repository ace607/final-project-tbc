//
//  RecommendedTableViewCell.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class RecommendedTableViewCell: UITableViewCell {
    @IBOutlet weak var recommendedTitle: UILabel!
    @IBOutlet weak var recommendationType: UILabel!
    @IBOutlet weak var recommendedCollection: UICollectionView!
    
    var articles = [Article]()
    
    private var isLoading = true
    
    static let identifier = "recommended_container_cell"
    
    let searchViewModel = SearchViewModel()
    
    var didSelectArticleAction: ((_ article: Article) -> Void)?
    
    var recommendedKeyword: String! {
        didSet {
            recommendedTitle.text = recommendedKeyword?.uppercased()
            loadRecommendedArticles()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recommendedCollection.delegate = self
        recommendedCollection.dataSource = self
        
        recommendedCollection.showsHorizontalScrollIndicator = false
        
        
        recommendedCollection.register(UINib(nibName: "RecommendedArticleCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: RecommendedArticleCollectionViewCell.identifier)
        
        
        
    }
    
    func loadRecommendedArticles() {
        searchViewModel.fetch(recommendedKeyword!) { articleResponse in
            self.articles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            
            self.articles = self.articles.count > 20 ? Array(self.articles[0..<20]) : self.articles
            
            DispatchQueue.main.async {
                self.recommendedCollection.reloadData()
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RecommendedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendedCollection.dequeueReusableCell(withReuseIdentifier: RecommendedArticleCollectionViewCell.identifier, for: indexPath) as! RecommendedArticleCollectionViewCell
        
        cell.isLoading(isLoading)
        
        if articles.count > 4 {
            cell.configure(title: articles[indexPath.row].title!, source: articles[indexPath.row].source.name!, photo: articles[indexPath.row].image!) {
                cell.isLoading(false)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectArticleAction?(articles[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
}
