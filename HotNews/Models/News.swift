//
//  News.swift
//  HotNews
//
//  Created by Александр Муклинов on 06.12.2023.
//

import Foundation

struct News: Hashable {
    
    let title: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
    var isLiked: Bool
}
