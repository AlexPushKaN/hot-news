//
//  CoreDataManager.swift
//  HotNews
//
//  Created by Александр Муклинов on 10.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
        }
        return container
    }()
    
    func getUserEntity(userID: String) -> UserEntity { return try! UserEntity.findOrCreate(userID, context: persistentContainer.viewContext) }
    func getFavorite(newsFor userEntity: UserEntity) -> [NewsEntity] { return try! NewsEntity.find(for: userEntity, in: persistentContainer.viewContext) }
    func createFavorite(news: News, for userEntity: UserEntity) { NewsEntity.create(news: news, for: userEntity, in: persistentContainer.viewContext) }
    func removeFavorite(news: News) {
        NewsEntity.removeFavorite(news: news, in: persistentContainer.viewContext)
    }
    
    func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private init() {}
}
