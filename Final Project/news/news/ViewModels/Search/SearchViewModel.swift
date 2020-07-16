//
//  SearchViewModel.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class SearchViewModel {
    public var fetch = { (query: String, completion: @escaping (ArticleResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/everything?q=\(query)&pageSize=100&language=en&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let articleResponse):
                completion(articleResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
