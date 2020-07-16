//
//  SourceTableViewCell.swift
//  news
//
//  Created by Admin on 7/12/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var sourceDesc: UILabel!
    @IBOutlet weak var sourceURL: UILabel!
    @IBOutlet weak var sourceLang: UILabel!
    @IBOutlet weak var sourceCountry: UILabel!
    @IBOutlet weak var sourceCountryView: UIView!
    
    static let identifier = "source_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sourceCountryView.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(source: Source) {
        sourceName.text = source.name
        sourceDesc.text = source.description
        sourceURL.text = source.url
        sourceLang.text = source.language
        
        sourceCountry.text = source.country?.uppercased()
    }
    
}
