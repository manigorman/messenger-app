//
//  ViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red // Фон нашего первоначального контроллера
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in") // Параметр, содержащий информацию: вошел ли пользователь
        
        if !isLoggedIn { // Если пользователь не входил
            let vc = LoginViewController() // Создаем ViewController для окна входа
            let nav = UINavigationController(rootViewController: vc) // создаем NavigationController с корневым ViewController в vc
            nav.modalPresentationStyle = .fullScreen // Стиль открытия nav - полноэкранный
            present(nav, animated: false) // Показать nav без анимации
        }
    }


}

