//
//  CovidHeaderTableViewCell.swift
//  news
//
//  Created by Admin on 7/10/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CovidHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var totalCases: UILabel!
    @IBOutlet weak var totalRecovered: UILabel!
    @IBOutlet weak var totalDeaths: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var newCases: UILabel!
    @IBOutlet weak var newRecovered: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    
    static let identifier = "covid_header_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        [firstStackView, secondStackView].forEach({ (stackView) in
            stackView.subviews.forEach { (view) in
                view.layer.cornerRadius = 10
            }
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(global: Global) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        totalCases.text = numberFormatter.string(from: NSNumber(value: global.totalConfirmed))
        totalRecovered.text = numberFormatter.string(from: NSNumber(value: global.totalRecovered))
        totalDeaths.text =  numberFormatter.string(from: NSNumber(value: global.totalDeaths))
        activeCases.text = numberFormatter.string(from: NSNumber(value: global.totalConfirmed - global.totalRecovered - global.totalDeaths))
        newCases.text = "+\(numberFormatter.string(from: NSNumber(value: global.newConfirmed)) ?? "")"
        newRecovered.text = "+\(numberFormatter.string(from: NSNumber(value: global.newRecovered)) ?? "")"
        newDeaths.text = "+\(numberFormatter.string(from: NSNumber(value: global.newDeaths)) ?? "")"
    }
    
}
