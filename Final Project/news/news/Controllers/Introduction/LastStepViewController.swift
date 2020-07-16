//
//  LastStepViewController.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class LastStepViewController: UIViewController {
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startBtn.rounded()
    }
    
    @IBAction func onStart(_ sender: UIButton) {
        UDManager.setFinished()
        CoreDataManager.saveData()
        performSegue(withIdentifier: "finished_intro_segue", sender: self)
    }
    

}
