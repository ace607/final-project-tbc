//
//  SourceArticlesViewModel.swift
//  news
//
//  Created by Admin on 7/13/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class SourceArticlesViewModel {
    public var fetch = { (source: String, completion: @escaping (ArticleResponse) -> ()) in
        APIService.service.get(url: "https://newsapi.org/v2/everything?sources=\(source)&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let articleResponse):
                completion(articleResponse)
            case .failure(let err):
                print(err)
            }
        }
    }
}
