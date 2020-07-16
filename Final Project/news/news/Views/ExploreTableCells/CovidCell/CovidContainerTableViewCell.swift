//
//  CovidContainerTableViewCell.swift
//  news
//
//  Created by Admin on 7/9/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CovidContainerTableViewCell: UITableViewCell {
    @IBOutlet weak var covidArticlesCollection: UICollectionView!
    @IBOutlet weak var moreInfoBtn: UIButton!
    
    var didSelectItemAction: ((Article) -> Void)?
    
    var didTapMoreInfo: (() -> Void)?
    
    var articles: [Article]! {
        didSet {
            covidArticlesCollection.reloadData()
        }
    }
    
    static let identifier = "covid_cell"
    
    private var isLoading = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        moreInfoBtn.rounded()
        
        covidArticlesCollection.delegate = self
        covidArticlesCollection.dataSource = self
        covidArticlesCollection.showsHorizontalScrollIndicator = false
        
        
        covidArticlesCollection.register(UINib(nibName: "CovidArticleCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "covid_article_cell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onMoreInfo(_ sender: UIButton) {
        didTapMoreInfo?()
    }
    
}

extension CovidContainerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           didSelectItemAction?(articles[indexPath.row])
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles != nil ? articles.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = covidArticlesCollection.dequeueReusableCell(withReuseIdentifier: "covid_article_cell", for: indexPath) as! CovidArticleCollectionViewCell
        
        
        cell.isLoading(isLoading)
        if articles.count > 10 {
            
            cell.configure(photo: articles[indexPath.row].image!, title: articles[indexPath.row].title!, source: articles[indexPath.row].source.name!) {
                cell.isLoading(false)
            }
        }
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 110)
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
