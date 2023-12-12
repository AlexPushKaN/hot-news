//
//  NewsEntity+CoreDataProperties.swift
//  HotNews
//
//  Created by Александр Муклинов on 10.12.2023.
//
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
    @NSManaged public var isLiked: Bool
    @NSManaged public var newsToUser: UserEntity?

}

extension NewsEntity : Identifiable {

}
