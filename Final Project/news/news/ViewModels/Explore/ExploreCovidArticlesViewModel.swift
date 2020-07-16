//
//  ExploreSourceArticlesViewModel.swift
//  news
//
//  Created by Admin on 7/9/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation


class CovidViewModel {
    public var fetch = { (completion: @escaping (ArticleResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/everything?q=covid&language=en&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let articleResponse):
                completion(articleResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
