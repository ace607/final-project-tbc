//
//  CurrentWeatherViewModel.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class CurrentWeatherViewModel {
    public var fetch = { (lat: String, lon: String, completion: @escaping (Weather) -> ()) in
        APIService.service.get(url: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=af2edb08b5beeacd412aa87266aea78d", needsHeader: false) { (result: Result<Weather, Error>) in
            switch result {
            case .success(let weather):
                completion(weather)
            case .failure(let err):
                print(err)
            }
        }
    }
}
