//
//  SourceViewModel.swift
//  news
//
//  Created by Admin on 7/12/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class SourceViewModel {
    public var fetch = { (completion: @escaping (SourceResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/sources?apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<SourceResponse, Error>) in
            switch result {
            case .success(let sourceResponse):
                completion(sourceResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
