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
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Новости"
        
        let userProfileViewController = UserProfileViewController()
        userProfileViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 1)
        
        viewControllers?.append(userProfileViewController)
    }
}

//MARK: - UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        switch item.tag {
            
        case 0: navigationItem.title = "Новости"
        case 1: navigationItem.title = "Профиль"
        default: break
        }
    }
}
