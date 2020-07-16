//
//  HeadlineCollectionViewCell.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class HeadlineCollectionViewCell: CardCell {
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var articlePhoto: UIImageView!
    
    static let identifier = "headline_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleView.layer.cornerRadius = Constants.photoRadius
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        
        
        contentView.layer.cornerRadius = Constants.photoRadius
        contentView.layer.masksToBounds = true
        
    }
    
    override func layoutSubviews() {
        if let gradient = titleView.layer.sublayers?[0], gradient.name == "gradient" {
            gradient.removeFromSuperlayer()
        }
        titleView.addGradientBackground(firstColor: .clear, secondColor: .black)
        super.layoutSubviews()
    }
    
    
    func configure(article: Article) {
        articleTitle.text = article.title
        
        article.image?.downloadImage(completion: { (img) in
            DispatchQueue.main.async {
                self.articlePhoto.image = img
            }
        })
        
    }
    
}
