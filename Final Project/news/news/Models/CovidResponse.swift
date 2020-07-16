//
//  CovidResponse.swift
//  news
//
//  Created by Admin on 7/10/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct CovidResponse: Codable {
    let global: Global
    let countries: [CovidCountry]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case countries = "Countries"
        case date = "Date"
    }
}

struct Global: Codable {
    let newConfirmed, totalConfirmed, newDeaths, totalDeaths: Int
    let newRecovered, totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}
