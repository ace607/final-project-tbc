//
//  ForYouViewController.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit
import CoreLocation

class ForYouViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var forYouTable: UITableView!
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    let currentWeatherViewModel = CurrentWeatherViewModel()
    
    var weather: Weather?
    
    var links: [SavedArticles] = [.readLater, .recent]
    
    var tappedLink: SavedArticles?
    
    var recommendedKeywords = CoreDataManager.fetchKeywords().shuffled()
    
    var selectedArticle: Article?
    
    var countryArticles = [Article]()
    
    let countryArticlesViewModel = CountryArticlesViewModel()
    
    let countries = Array(CoreDataManager.fetchCountries().map { $0.id! }.shuffled()[0..<2])
    
    private var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forYouTable.delegate = self
        forYouTable.dataSource = self
        
        checkLocationServiceEnabled()
        forYouTable.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        forYouTable.register(UINib(nibName: "SavedArticleLinkTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: SavedArticleLinkTableViewCell.identifier)
        forYouTable.register(UINib(nibName: "RecommendedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: RecommendedTableViewCell.identifier)
        forYouTable.register(UINib(nibName: "RecommendedReadsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: RecommendedReadsTableViewCell.identifier)
        
        forYouTable.register(UINib(nibName: "CategoryHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "category_header")
        
        forYouTable.register(UINib(nibName: "LargeCategoryTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: LargeCategoryTableViewCell.identifier)
        
        countryArticlesViewModel.fetch(countries[0]) { articleResponse in
            
            let luckyCountry = articleResponse.articles.filter { $0.title != nil && $0.image != nil && $0.image != "null" }
            
            self.countryArticles.append(contentsOf: luckyCountry.count > 10 ? Array(luckyCountry[0..<10]) : luckyCountry)
            DispatchQueue.main.async {
                self.countryArticles = self.countryArticles.count > 3 ? self.countryArticles.shuffled() : self.countryArticles
                self.forYouTable.reloadData()
            }
        }
        
    }
    
    private func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkAuthorizationStatus()
            self.currentLocation = locationManager.location
        } else {
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        @unknown default:
            print("")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        self.currentLocation = location
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            
            currentWeatherViewModel.fetch(lat , lon) { weather in
                self.weather = weather
                DispatchQueue.main.async {
                    self.forYouTable.reloadData()
                }
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "show_saved_articles" {
            if let savedVC = segue.destination as? SavedArticlesViewController {
                savedVC.savedTitle = tappedLink
            }
        }
        
        if let identifier = segue.identifier, identifier == "for_you_article_details" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.selectedArticle = selectedArticle
            }
        }
    }
    
}

extension ForYouViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return countryArticles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = forYouTable.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            
            let userName = CoreDataManager.fetchUser().name
            
            cell.configure(userName: userName!)
            
            if weather != nil {
                cell.configureWeather(weather: weather!)
            }
            
            cell.selectionStyle = .none
            
            
            return cell
        case 1:
            let cell = forYouTable.dequeueReusableCell(withIdentifier: SavedArticleLinkTableViewCell.identifier, for: indexPath) as! SavedArticleLinkTableViewCell
            
            cell.linkName.text = links[indexPath.row].rawValue
            
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = forYouTable.dequeueReusableCell(withIdentifier: RecommendedTableViewCell.identifier, for: indexPath) as! RecommendedTableViewCell
            
            cell.recommendedKeyword = recommendedKeywords[0].name
            
            cell.didSelectArticleAction = { [weak self] article in
                self?.selectedArticle = article
                self?.performSegue(withIdentifier: "for_you_article_details", sender: self)
            }
            
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = forYouTable.dequeueReusableCell(withIdentifier: RecommendedReadsTableViewCell.identifier, for: indexPath) as! RecommendedReadsTableViewCell
            
            
            cell.didSelectArticleAction = { [weak self] article in
                self?.selectedArticle = article
                self?.performSegue(withIdentifier: "for_you_article_details", sender: self)
            }
            
            cell.selectionStyle = .none
            return cell
            
        case 4:
            let cell = forYouTable.dequeueReusableCell(withIdentifier: RecommendedTableViewCell.identifier, for: indexPath) as! RecommendedTableViewCell
            
            cell.recommendedKeyword = recommendedKeywords[1].name
            
            cell.didSelectArticleAction = { [weak self] article in
                self?.selectedArticle = article
                self?.performSegue(withIdentifier: "for_you_article_details", sender: self)
            }
            
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell = forYouTable.dequeueReusableCell(withIdentifier: "large_category_cell", for: indexPath) as! LargeCategoryTableViewCell
            
            cell.isLoading(isLoading)
            
            if countryArticles.count > 0 {
                
                cell.configure(photo: countryArticles[indexPath.row].image!, title: countryArticles[indexPath.row].title!, source: countryArticles[indexPath.row].source.name!, date: countryArticles[indexPath.row].date!) {
                    cell.isLoading(false)
                }
            }
            cell.selectionStyle = .none
            
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            tappedLink = links[indexPath.row]
            performSegue(withIdentifier: "show_saved_articles", sender: self)
        }
        if indexPath.section == 5 {
            selectedArticle = countryArticles[indexPath.row]
            performSegue(withIdentifier: "for_you_article_details", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 5 { return 45 }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Dequeue with the reuse identifier
        let header = self.forYouTable.dequeueReusableHeaderFooterView(withIdentifier: "category_header") as! CategoryHeaderView
        if section == 5 {
            header.categoryName.text = "More for you".uppercased()
            
            return header
        }
        
        return UIView()
    }
    
}
