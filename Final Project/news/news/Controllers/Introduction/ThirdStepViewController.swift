//
//  ThirdStepViewController.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class ThirdStepViewController: UIViewController {
    @IBOutlet weak var categoriesTable: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    
    var selectedCategories = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTable.delegate = self
        categoriesTable.dataSource = self
        
        nextBtn.rounded()
        
        categoriesTable.register(UINib(nibName: "ThirdStepCategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "third_step_category_cell")
    }
    
    @IBAction func onNext(_ sender: UIButton) {
        
        if selectedCategories.count < 3 {
            showInfoAlert(title: "Warning", message: "You have to select at least 3 categories.")
        } else {
            CoreDataManager.selectedCategories = Array(selectedCategories)
            performSegue(withIdentifier: "show_fourth_intro_page", sender: self)
        }
    }
    
}

extension ThirdStepViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ThirdStepCategoryTableViewCell
        
        cell.isChecked = !selectedCategories.contains(Constants.categories[indexPath.row])
        
        if cell.isChecked {
            selectedCategories.insert(Constants.categories[indexPath.row])
        } else {
            selectedCategories.remove(Constants.categories[indexPath.row])
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTable.dequeueReusableCell(withIdentifier: "third_step_category_cell", for: indexPath) as! ThirdStepCategoryTableViewCell
        
        cell.categoryName.text = Constants.categories[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
