//
//  MainTabBarController.swift
//  HotNews
//
//  Created by Александр Муклинов on 08.12.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userProfileViewController = UserProfileViewController()
        if var controllers = viewControllers {
            
            userProfileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: controllers.count)
            controllers.append(userProfileViewController)
            viewControllers = controllers
        }
    }
}
