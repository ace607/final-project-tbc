//
//  SecondStepCountryTableViewCell.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SecondStepCountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var checkedIcon: UIImageView!
    
    var isChecked: Bool = false {
        didSet {
            self.checkedIcon.isHidden = !isChecked
            self.countryName.textColor = isChecked ? Constants.purple : Constants.grayText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.checkedIcon.isHidden = !isChecked
        self.checkedIcon.image = self.checkedIcon.image?.withRenderingMode(.alwaysTemplate)
        self.checkedIcon.tintColor = Constants.purple
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
