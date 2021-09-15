//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            let vc = LoginViewController() // Создаем ViewController для окна входа
            let nav = UINavigationController(rootViewController: vc) // создаем NavigationController с корневым ViewController в vc
            nav.modalPresentationStyle = .fullScreen // Стиль открытия nav - полноэкранный
            present(nav, animated: true) // Показать nav без анимации
        }
        catch {
            print("Failed to log out.")
        }
    }
}
