//
//  ViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationVC: UIViewController {

    // MARK: - Properties
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let tableView: UITableView = {
       
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "No conversations"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegate()
        fetchConversations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(didTapComposeButton))
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.topAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Selectors
    
    @objc private func didTapComposeButton() {
        let vc = NewConversationVC()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    // MARK: - Methods
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil { // Если пользователь не входил
            let vc = LoginVC() // Создаем ViewController для окна входа
            let nav = UINavigationController(rootViewController: vc) // создаем NavigationController с корневым ViewController в vc
            nav.modalPresentationStyle = .fullScreen // Стиль открытия nav - полноэкранный
            present(nav, animated: false) // Показать nav без анимации
        }
    }
    
    private func fetchConversations() {
        tableView.isHidden = false
    }
    
}
