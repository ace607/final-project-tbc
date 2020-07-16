//
//  RecommendedReadsTableViewCell.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class RecommendedReadsTableViewCell: UITableViewCell {
    @IBOutlet weak var recommendedReadsCollection: UICollectionView!
    
    static let identifier = "recommended_reads_container"
    
    var articles = [Article]()
    
    let sourceViewModel = SourceViewModel()
    let sourceArticlesViewModel = SourceArticlesViewModel()
    var sources = CoreDataManager.fetchRecents().map { $0.source }
    var didSelectArticleAction: ((_ article: Article) -> Void)?
    
    private var isLoading = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        recommendedReadsCollection.delegate = self
        recommendedReadsCollection.dataSource = self
        
        recommendedReadsCollection.showsHorizontalScrollIndicator = false
        
        
        recommendedReadsCollection.register(UINib(nibName: "RecommendedReadCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: RecommendedReadCollectionViewCell.identifier)
        
        sourceViewModel.fetch { sourceResponse in
            
            let filteredSources = sourceResponse.sources.filter { self.sources.contains($0.name) }.map { $0.id }
            
            self.sources = filteredSources.count > 0 ? filteredSources : sourceResponse.sources.map { $0.id }
            
            DispatchQueue.main.async {

                self.sourceArticlesViewModel.fetch(self.sources.map { $0! }.joined(separator: ",")) { articleResponse in

                    self.articles = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }.shuffled()


                    DispatchQueue.main.async {
                        self.recommendedReadsCollection.reloadData()
                    }

                }

            }
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension RecommendedReadsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendedReadsCollection.dequeueReusableCell(withReuseIdentifier: RecommendedReadCollectionViewCell.identifier, for: indexPath) as! RecommendedReadCollectionViewCell
        
        cell.isLoading(isLoading)
        
        if articles.count > 2 {
            
            cell.configure(photo: articles[indexPath.row].image!, title: articles[indexPath.row].title!, source: articles[indexPath.row].source.name!, date: articles[indexPath.row].date!) {
                cell.isLoading(false)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 260, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectArticleAction?(articles[indexPath.row])
    }
    
}
