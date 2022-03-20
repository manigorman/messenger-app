//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    // MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .null, style: .insetGrouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
    
    let data = ["Log Out", "Friends", "Music", "About"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegate()
        
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        title = "Profile"
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
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
    
    // MARK: - Methods

}
