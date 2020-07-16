//
//  SavedArticleLinkTableViewCell.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SavedArticleLinkTableViewCell: UITableViewCell {
    @IBOutlet weak var linkName: UILabel!
    @IBOutlet weak var nextIcon: UIImageView!
    @IBOutlet weak var linkView: UIView!
    
    static let identifier = "saved_articles_link"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nextIcon.image = nextIcon.image?.withRenderingMode(.alwaysTemplate)
        nextIcon.tintColor = Constants.grayText
        
        linkView.layer.cornerRadius = 8
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
