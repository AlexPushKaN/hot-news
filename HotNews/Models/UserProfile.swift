//
//  UserProfile.swift
//  HotNews
//
//  Created by Александр Муклинов on 08.12.2023.
//

import Foundation

class UserProfile {
    
    var id: String
    var name: String
    var email: String
    var photo: String
    var password: String

    static let shared = UserProfile()

    private init() {
        
        id = UUID().uuidString
        name = ""
        email = "test@mail.ru"
        photo = "userPhoto"
        password = "12345"
    }

    func save() {
        
        let profileData: [String: Any] = [
            "id": id,
            "name": name,
            "email": email,
            "photo": photo,
            "password": password
        ]
        UserDefaults.standard.set(profileData, forKey: "userProfile")
    }

    func load() {
        
        if let profileData = UserDefaults.standard.dictionary(forKey: "userProfile") {
            id = profileData["id"] as? String ?? ""
            name = profileData["name"] as? String ?? ""
            email = profileData["email"] as? String ?? ""
            photo = profileData["photo"] as? String ?? ""
            password = profileData["password"] as? String ?? ""
        }
    }
    
    func delete() {
        
        UserDefaults.standard.removeObject(forKey: "userProfile")

        id = ""
        name = ""
        email = ""
        photo = ""
        password = ""
        
        save()
    }
}
