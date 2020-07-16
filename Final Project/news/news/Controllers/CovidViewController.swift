//
//  CovidViewController.swift
//  news
//
//  Created by Admin on 7/10/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class CovidViewController: UIViewController {
    @IBOutlet weak var covidTable: UITableView!
    
    let covidStatsViewModel = CovidStatsViewModel()
    var covidResponse: CovidResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        covidTable.delegate = self
        covidTable.dataSource = self
        
        covidStatsViewModel.fetch { response in
            self.covidResponse = response
            DispatchQueue.main.async {
                self.covidTable.reloadData()
            }
        }
        
        covidTable.register(UINib(nibName: "CovidHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CovidHeaderTableViewCell.identifier)
        
        covidTable.register(UINib(nibName: "CovidCountryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: CovidCountryTableViewCell.identifier)

    }

}

extension CovidViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let response = covidResponse {
                return response.countries.count
            }
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = covidTable.dequeueReusableCell(withIdentifier: "covid_header_cell", for: indexPath) as! CovidHeaderTableViewCell
            
            if let response = covidResponse {
                cell.configure(global: response.global)
            }
            
            cell.selectionStyle = .none
            
            return cell
        case 1:
            let cell = covidTable.dequeueReusableCell(withIdentifier: "covid_country_cell", for: indexPath) as! CovidCountryTableViewCell
            
            if let response = covidResponse {
                cell.configure(countryInfo: response.countries[indexPath.row])
            }
            
            cell.selectionStyle = .none
            
            return cell
        default:
        return UITableViewCell()
        }
    }
}
