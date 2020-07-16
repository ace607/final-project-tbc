//
//  Weather.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var coord: Coord
    var weather: [WeatherInfo]
    var main: MainInfo
    var name: String
}

struct WeatherInfo: Codable {
    var main: String
    var description: String
    var icon: String
}

struct Coord: Codable {
    var lat: Double
    var lon: Double
}

struct MainInfo: Codable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
