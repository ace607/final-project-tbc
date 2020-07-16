//
//  SecondStepViewController.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SecondStepViewController: UIViewController {
    
    @IBOutlet weak var countriesTable: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var selectedCountries = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesTable.delegate = self
        countriesTable.dataSource = self
        
        countriesTable.register(UINib(nibName: "SecondStepCountryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "second_step_country_cell")
        
        nextBtn.rounded()
        
    }
    @IBAction func onNext(_ sender: UIButton) {
        if selectedCountries.count < 3 {
            showInfoAlert(title: "Warning", message: "You have to select at least 3 countries.")
        } else {
            CoreDataManager.selectedCountries = Constants.countries.filter {
                selectedCountries.contains($0.1)
            }
            
            performSegue(withIdentifier: "show_third_intro_page", sender: self)
        }
    }
    
}

extension SecondStepViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SecondStepCountryTableViewCell
        
        cell.isChecked = !selectedCountries.contains(Constants.countries[indexPath.row].1)
        
        if cell.isChecked {
            selectedCountries.insert(Constants.countries[indexPath.row].1)
        } else {
            selectedCountries.remove(Constants.countries[indexPath.row].1)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTable.dequeueReusableCell(withIdentifier: "second_step_country_cell", for: indexPath) as! SecondStepCountryTableViewCell
        
        cell.countryName.text = Constants.countries[indexPath.row].0
        cell.isChecked = selectedCountries.contains(Constants.countries[indexPath.row].1)
        
        return cell
    }
}
