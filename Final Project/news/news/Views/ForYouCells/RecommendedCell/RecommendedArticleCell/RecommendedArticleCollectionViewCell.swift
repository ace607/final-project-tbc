//
//  RecommendedArticleCollectionViewCell.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import ShimmerBlocks

class RecommendedArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    
    static let identifier = "recommended_article_cell"
    
    private lazy var shimmerContainer = ShimmerContainer(parentView: self)
    
    private lazy var shimmerData: [ShimmerData] = {
        let titleSections = ShimmerSection.generate(minWidth: 50, height: 21, totalWidth: 150, maxNumberOfSections: 3)
        return [ShimmerData(articleTitle, sectionSpacing: 6, sections: titleSections),
                ShimmerData(articlePhoto, matchViewDimensions: true),
                ShimmerData(articleSource, matchViewDimensions: true)]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        articlePhoto.layer.cornerRadius = Constants.photoRadius
    }
    
    func isLoading(_ loading: Bool) {
        shimmerContainer.applyShimmer(enable: loading, with: shimmerData)
    }
    
    func configure(title: String, source: String, photo: String, completion: @escaping () -> ()) {
        articleTitle.text = title
        articleSource.text = source
        
        photo.downloadImage { (img) in
            DispatchQueue.main.async {
                self.articlePhoto.image = img
                completion()
            }
        }
    }

}
