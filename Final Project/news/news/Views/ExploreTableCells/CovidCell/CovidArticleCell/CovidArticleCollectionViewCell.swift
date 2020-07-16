//
//  CovidArticleCollectionViewCell.swift
//  news
//
//  Created by Admin on 7/9/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import ShimmerBlocks

class CovidArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    
    static let identifier = "covid_article_cell"
    
    private lazy var shimmerContainer = ShimmerContainer(parentView: self)

    private lazy var shimmerData: [ShimmerData] = {
           let titleSections = ShimmerSection.generate(minWidth: 50, height: 21, totalWidth: 150, maxNumberOfSections: 3)
           return [ShimmerData(articleTitle, sectionSpacing: 6, sections: titleSections),
                   ShimmerData(articlePhoto, matchViewDimensions: true)]
       }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        articlePhoto.layer.cornerRadius = Constants.photoRadius
        
    }
    func isLoading(_ loading: Bool) {
        shimmerContainer.applyShimmer(enable: loading, with: shimmerData)
    }
    
    func configure(photo: String, title: String, source: String, completion: @escaping () -> ()) {
        articleTitle.text = title
        articleSource.text = source == "" ? "Unknown source" : source
        photo.downloadImage { (img) in
            DispatchQueue.main.async {
                self.articlePhoto.image = img
                completion()
            }
        }
    }
}
