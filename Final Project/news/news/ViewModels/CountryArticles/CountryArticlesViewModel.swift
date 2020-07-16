//
//  CountryArticlesViewModel.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class CountryArticlesViewModel {
    public var fetch = { (country: String, completion: @escaping (ArticleResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/top-headlines?pageSize=20&country=\(country)&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let articleResponse):
                completion(articleResponse)
            case .failure(let err):
                print(err)
            }
            
        }
    }
}
