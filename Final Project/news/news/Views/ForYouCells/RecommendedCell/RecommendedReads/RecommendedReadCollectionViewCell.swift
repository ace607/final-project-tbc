//
//  RecommendedReadCollectionViewCell.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import ShimmerBlocks

class RecommendedReadCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    
    static let identifier = "recommended_read_cell"
    
    
    private lazy var shimmerContainer = ShimmerContainer(parentView: self)
    
    private lazy var shimmerData: [ShimmerData] = {
        let titleSections = ShimmerSection.generate(minWidth: 50, height: 21, totalWidth: 150, maxNumberOfSections: 3)
        return [ShimmerData(articleTitle, sectionSpacing: 6, sections: titleSections),
                ShimmerData(articlePhoto, matchViewDimensions: true),
                ShimmerData(articleSource, matchViewDimensions: true),
                ShimmerData(articleDate, matchViewDimensions: true)]
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.layer.cornerRadius = Constants.photoRadius
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 1
        
        articlePhoto.layer.cornerRadius = Constants.photoRadius
        articlePhoto.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.backgroundColor = .clear
        
        contentView.backgroundColor = .white
        
        self.layer.masksToBounds = false
        contentView.layer.masksToBounds = false
    }
    
    func isLoading(_ loading: Bool) {
        shimmerContainer.applyShimmer(enable: loading, with: shimmerData)
    }
    
    func configure(photo: String, title: String, source: String, date: String, completion: @escaping () -> ()) {
        articleTitle.text = title
        articleSource.text = source
        articleDate.text = date.toHM()
        
        photo.downloadImage { (img) in
            DispatchQueue.main.async {
                self.articlePhoto.image = img
                completion()
            }
        }
    }

}
