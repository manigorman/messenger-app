//
//  MainTabBarVC.swift
//  Messenger
//
//  Created by Igor Manakov on 14.03.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    
    func setupTabBar() {
        tabBar.backgroundColor = .red
        
        
        
        let chatsVC = UINavigationController(rootViewController: ConversationViewController())
        chatsVC.tabBarItem.image = UIImage(systemName: "house")
        chatsVC.tabBarItem.image = UIImage(systemName: "house.fill")
        chatsVC.title = "Chats"
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
//        profileVC.tabBarItem.image = unselected
//        profileVC.tabBarItem.image = selected
        chatsVC.title = "Profile"
        
        setViewControllers([chatsVC, profileVC], animated: false)
    }
}
