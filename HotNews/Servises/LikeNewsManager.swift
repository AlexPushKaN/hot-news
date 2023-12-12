//
//  LikeManager.swift
//  HotNews
//
//  Created by Александр Муклинов on 06.12.2023.
//

import Foundation

class LikeNewsManager {
    
    static let shared = LikeNewsManager()
    
    let coreDataManager = CoreDataManager.shared
    lazy var userEntity: UserEntity = { return coreDataManager.getUserEntity(userID: UserProfile.shared.id) }()
    weak var newsMaker: NewsMaker? = nil {
        didSet {
            if let newsMaker = self.newsMaker {
                self.likedNews = Set(newsMaker.favoriteNews)
            }
        }
    }
    private var likedNews: Set<News> = []

    func isLiked(_ news: News) -> Bool { return likedNews.contains(news) }
    
    func toggleLike(news: News) {
        if likedNews.contains(news) {
            likedNews.remove(news)
            coreDataManager.removeFavorite(news: news)
            coreDataManager.saveContext()
        } else {
            likedNews.insert(news)
            coreDataManager.createFavorite(news: news, for: userEntity)
            coreDataManager.saveContext()
        }
    }
    
    func getLikedNews() -> [News] { return Array(likedNews) }
}
