//
//  CategoryListCollectionViewCell.swift
//  news
//
//  Created by Admin on 7/7/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CategoryListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = true
        self.layer.cornerRadius = Constants.photoRadius
    }

}
