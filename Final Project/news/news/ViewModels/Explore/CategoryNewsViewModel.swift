//
//  CategoryNewsViewModel.swift
//  news
//
//  Created by Admin on 7/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class CategoryNewsViewModel {
    public var fetch = { (category: String, completion: @escaping (ArticleResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/top-headlines?category=\(category)&country=us&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let articleResponse):
                completion(articleResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
