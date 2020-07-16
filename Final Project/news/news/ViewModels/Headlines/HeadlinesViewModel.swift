//
//  HeadlinesViewModel.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class HeadlinesViewModel {
    public var fetch = { (completion: @escaping (ArticleResponse) -> ()) in
        
        APIService.service.get(url: "https://newsapi.org/v2/sources?language=en&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<SourceResponse, Error>) in
            switch result {
            case .success(let sources):
                let sourceList = sources.sources
                let ids = sourceList.map { $0.id! }
                let idURL = ids.joined(separator: ",")
                APIService.service.get(url: "https://newsapi.org/v2/everything?sources=\(idURL)&pageSize=100&apiKey=\(Constants.apiKey)", needsHeader: true) { (result: Result<ArticleResponse, Error>) in
                    switch result {
                    case .success(let articleResponse):
                        completion(articleResponse)
                    case .failure(let err):
                        print(err)
                    }
                }
            case .failure(let err):
                print(err)
            }
        }
        
    }
}
