//
//  SourcesViewController.swift
//  news
//
//  Created by Admin on 7/12/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController {
    @IBOutlet weak var sourcesTable: UITableView!
    
    var sources = [Source]()
    var filteredSources = [Source]()
    
    let sourceViewModel = SourceViewModel()
    
    var selectedSource: Source?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourcesTable.delegate = self
        sourcesTable.dataSource = self
        
        sourcesTable.register(UINib(nibName: "SourcesHeaderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: SourcesHeaderTableViewCell.identifier)
        sourcesTable.register(UINib(nibName: "SourceTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: SourceTableViewCell.identifier)
        
        sourceViewModel.fetch { sourceResponse in
            self.sources = sourceResponse.sources
            self.filteredSources = self.sources
            DispatchQueue.main.async {
                self.sourcesTable.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_source_articles" {
            if let articlesVC = segue.destination as? SourceArticlesViewController {
                articlesVC.selectedSource = selectedSource
            }
        }
    }

}

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            selectedSource = sources[indexPath.row]
            performSegue(withIdentifier: "show_source_articles", sender: self)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        case 2:
            return filteredSources.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = sourcesTable.dequeueReusableCell(withIdentifier: SourcesHeaderTableViewCell.identifier, for: indexPath) as! SourcesHeaderTableViewCell
            
            cell.isUserInteractionEnabled = false
            
            return cell
        case 2:
            let cell = sourcesTable.dequeueReusableCell(withIdentifier: SourceTableViewCell.identifier, for: indexPath) as! SourceTableViewCell
            
            if filteredSources.count > 0 {
                cell.configure(source: filteredSources[indexPath.row])
            }
            
            cell.selectionStyle = .none
            
            return cell
        default:
            return UITableViewCell()
        }

    }
    
    
}
