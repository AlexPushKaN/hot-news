//
//  LikeManager.swift
//  HotNews
//
//  Created by Александр Муклинов on 06.12.2023.
//

import Foundation

class LikeNewsManager {
    
    static let shared = LikeNewsManager()
    private var likedNews: Set<News> = []
    
    private init() {}
    
    func isLiked(_ news: News) -> Bool { return likedNews.contains(news) }
    
    func toggleLike(news: News) {
        
        if likedNews.contains(news) { likedNews.remove(news) }
        else { likedNews.insert(news) }
    }
}
