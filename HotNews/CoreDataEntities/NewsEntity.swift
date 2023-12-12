//
//  NewsEntity.swift
//  HotNews
//
//  Created by Александр Муклинов on 10.12.2023.
//

import Foundation
import CoreData

class NewsEntity: NSManagedObject {
    
    class func find(for userEntity: UserEntity, in context: NSManagedObjectContext) throws -> [NewsEntity] {
        let request: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "user.id == %@", userEntity.id!)
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
    
    class func create(news: News, for userEntity: UserEntity, in context: NSManagedObjectContext) {
        let request: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", news.id)
        do {
            let fetcResult = try context.fetch(request)
            if fetcResult.count > 0 {
                assert(fetcResult.count == 1, "База данных содержит дубликат новости!")
            }
        } catch {
            print("Возникла ошибка: \(error.localizedDescription) в ходе извлечения новости из базы данных!")
        }
        let newsEntity = NewsEntity(context: context)
        newsEntity.id = news.id
        newsEntity.title = news.title
        newsEntity.url = news.url
        newsEntity.urlToImage = news.urlToImage
        newsEntity.publishedAt = news.publishedAt
        newsEntity.content = news.content
        newsEntity.isLiked = news.isLiked
        newsEntity.user = userEntity
    }
    
    class func removeFavorite(news: News, in context: NSManagedObjectContext) {
        let request: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", news.id)
        do {
            let fetcResult = try context.fetch(request)
            if let favoriteNewsToDelete = fetcResult.first {
                context.delete(favoriteNewsToDelete)
            }
        } catch {
            print("Возникла ошибка: \(error.localizedDescription) в ходе извлечения новости из базы данных!")
        }
    }
}
