//
//  ArticleResponse.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

struct ArticleResponse: Codable {
    let totalResults: Int?
    let articles: [Article]
}
