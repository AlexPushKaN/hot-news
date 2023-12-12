//
//  UserEntity.swift
//  HotNews
//
//  Created by Александр Муклинов on 10.12.2023.
//

import Foundation
import CoreData

class UserEntity: NSManagedObject {
    
    class func findOrCreate(_ userID: String, context: NSManagedObjectContext) throws -> UserEntity {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", userID)
        do {
            let fetcResult = try context.fetch(request)
            if fetcResult.count > 0 {
                assert(fetcResult.count == 1, "База данных содержит дубликат пользователя!")
                return fetcResult[0]
            }
        } catch {
            throw error
        }
        let userEntity = UserEntity(context: context)
        userEntity.id = userID
        return userEntity
    }
}
