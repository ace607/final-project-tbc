//
//  Article.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: ArticleSource
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let image: String?
    let date: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, content
        case image = "urlToImage"
        case date = "publishedAt"
    }
}

struct ArticleSource: Codable {
    let id: String?
    let name: String?
}
