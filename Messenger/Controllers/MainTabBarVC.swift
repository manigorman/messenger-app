//
//  MainTabBarVC.swift
//  Messenger
//
//  Created by Igor Manakov on 14.03.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {

    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    // MARK: - Setup
    
    func setupTabBar() {
        
        let chatsVC = createNavController(with: ConversationVC(), selected: UIImage(systemName: "house"), unselected: UIImage(systemName: "house.fill"), title: "Chats")
        
        let profileVC = createNavController(with: ProfileVC(), selected: nil, unselected: nil, title: "Profile")
        
        setViewControllers([chatsVC, profileVC], animated: false)
    }
    
    func createNavController(with vc: UIViewController, selected: UIImage?, unselected: UIImage?, title: String) -> UINavigationController {
            let viewController = vc
            let navController = UINavigationController(rootViewController: viewController)
            navController.tabBarItem.image = unselected
            navController.tabBarItem.image = selected
            navController.title = title
            
            return navController
        }
}
