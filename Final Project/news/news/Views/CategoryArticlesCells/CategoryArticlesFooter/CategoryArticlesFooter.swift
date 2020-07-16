//
//  CategoryArticlesFooter.swift
//  news
//
//  Created by Admin on 7/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CategoryArticlesFooter: UITableViewHeaderFooterView {
    @IBOutlet weak var loadMoreBtn: UIButton!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        loadMoreBtn.rounded()
        loadMoreBtn.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        loadMoreBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        loadMoreBtn.layer.shadowRadius = 6
        loadMoreBtn.layer.shadowOpacity = 1
        
    }
    @IBAction func onLoadMore(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("load_more"), object: nil)
    }
    
}
