//
//  CategoryArticlesViewModel.swift
//  news
//
//  Created by Admin on 7/8/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class CategoryArticlesViewModel {
    public var fetch = { (category: String, page: Int, completion: @escaping (ArticleResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/top-headlines?category=\(category)&country=us&pageSize=20&page=\(page)&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let articleResponse):
                completion(articleResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
