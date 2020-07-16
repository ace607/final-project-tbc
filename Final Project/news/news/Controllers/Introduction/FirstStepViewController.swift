//
//  FirstStepViewController.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class FirstStepViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBAction func onNext(_ sender: UIButton) {
        if nameField.text == "" || ageField.text == "" || emailField.text == "" {
            showInfoAlert(title: "Error", message: "Please, fill all fields.")
        } else if Int(ageField.text!) == nil {
            showInfoAlert(title: "Error", message: "Age must be an integer.")
        } else if !emailField.text!.contains("@") {
            showInfoAlert(title: "Error", message: "Please, enter valid e-mail address.")
        } else {
            CoreDataManager.name = nameField.text!
            CoreDataManager.age = Int(ageField.text!)!
            CoreDataManager.email = emailField.text!
            performSegue(withIdentifier: "show_second_intro_page", sender: self)
        }
    }
    
    private func setupViews() {
        nameField.bottomBordered()
        ageField.bottomBordered()
        emailField.bottomBordered()
        nextBtn.rounded()
    }
    
}
