//
//  CovidViewModel.swift
//  news
//
//  Created by Admin on 7/10/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class CovidStatsViewModel {
    public var fetch = { (completion: @escaping (CovidResponse) -> ()) in
        APIService.service.get(url: "https://api.covid19api.com/summary", needsHeader: false) { (result: Result<CovidResponse, Error>) in
            switch result {
            case .success(let covidResponse):
                completion(covidResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
