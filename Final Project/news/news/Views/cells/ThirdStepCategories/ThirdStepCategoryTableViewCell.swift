//
//  ThirdStepCategoryTableViewCell.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ThirdStepCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    
    var isChecked: Bool = false {
        didSet {
            self.bgView.backgroundColor = isChecked ? Constants.purple : Constants.lightGrayBackground
            self.categoryName.textColor = isChecked ? .white : Constants.lightGrayText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 10
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 50, bottom: 5, right: 50))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
