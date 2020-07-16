//
//  WeatherTableViewCell.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDegrees: UILabel!
    @IBOutlet weak var weatherCity: UILabel!
    @IBOutlet weak var weatherInfo: UILabel!
    
    static let identifier = "weather_cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        weatherView.layer.cornerRadius = Constants.photoRadius
        
        weatherView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        weatherView.layer.shadowOffset = CGSize(width: 0, height: 2)
        weatherView.layer.shadowRadius = 6
        weatherView.layer.shadowOpacity = 1
        
        weatherCity.text = ""
        weatherInfo.text = ""
        weatherDegrees.text = ""
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(userName: String) {
        welcomeMessage.text = "Hello \(userName.capitalized)!"
    }
    
    
    func configureWeather(weather: Weather) {
        weatherCity.text = weather.name
        weatherDegrees.text = String(format: "%.0f", weather.main.temp - 273.15) + "°C"
        weatherInfo.text = weather.weather[0].description
        let url = "http://openweathermap.org/img/wn/\(weather.weather[0].icon)@4x.png"
        url.downloadImage { (img) in
            DispatchQueue.main.async {
                self.weatherIcon.image = img
            }
        }
        
        self.layoutIfNeeded()
    }
}
