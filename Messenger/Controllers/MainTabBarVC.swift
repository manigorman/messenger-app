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
        
        let chatVC = createNavController(with: ConversationVC(), selected: UIImage(systemName: "message.fill"), unselected: UIImage(systemName: "message"), title: "Messenger")
        
        let profileVC = createNavController(with: ProfileVC(), selected: UIImage(systemName: "person.fill"), unselected: UIImage(systemName: "person"), title: "Profile")
        
        setViewControllers([chatVC, profileVC], animated: false)
    }
    
    func createNavController(with vc: UIViewController, selected: UIImage?, unselected: UIImage?, title: String) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        navController.title = title
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
}
