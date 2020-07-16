//
//  FourthStepViewController.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class FourthStepViewController: UIViewController {
    @IBOutlet weak var keywordsField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!

    var keywords = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordsField.bottomBordered()
        nextBtn.rounded()
        
    }
    
    @IBAction func onNext(_ sender: UIButton) {
        if keywordsField.text != "" {
            keywords = keywordsField.text!.components(separatedBy: ", ")
            if keywords.count < 2 {
                showInfoAlert(title: "Error", message: "Please enter at least two keywords..")
            } else {
                CoreDataManager.keywords = keywords
                performSegue(withIdentifier: "show_last_intro_page", sender: self)
            }
        } else if keywordsField.text! == "" {
            showInfoAlert(title: "Error", message: "Please enter at least two keywords..")
        }
        
    }
    
}
