//
//  CategoryArticleTableViewCell.swift
//  news
//
//  Created by Admin on 7/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import ShimmerBlocks


class CategoryArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    
    static let identifier = "category_article_cell"
    
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
        
        articlePhoto.layer.cornerRadius = Constants.photoRadius
        
        self.layer.backgroundColor = UIColor.black.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
