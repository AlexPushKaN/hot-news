//
//  UserEntity+CoreDataProperties.swift
//  HotNews
//
//  Created by Александр Муклинов on 10.12.2023.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var userToNews: NSSet?

}

// MARK: Generated accessors for userToNews
extension UserEntity {

    @objc(addUserToNewsObject:)
    @NSManaged public func addToUserToNews(_ value: NewsEntity)

    @objc(removeUserToNewsObject:)
    @NSManaged public func removeFromUserToNews(_ value: NewsEntity)

    @objc(addUserToNews:)
    @NSManaged public func addToUserToNews(_ values: NSSet)

    @objc(removeUserToNews:)
    @NSManaged public func removeFromUserToNews(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
