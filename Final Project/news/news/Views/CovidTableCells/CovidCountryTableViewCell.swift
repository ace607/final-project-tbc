//
//  CovidCountryTableViewCell.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CovidCountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    
    static let identifier = "covid_country_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(countryInfo: CovidCountry) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        countryName.text = countryInfo.country
        totalCases.text = numberFormatter.string(from: NSNumber(value: countryInfo.totalConfirmed))
        totalDeaths.text = numberFormatter.string(from: NSNumber(value: countryInfo.totalDeaths))
    }
    
}
