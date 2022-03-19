//
//  NewConversationViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {
    
    // MARK: - Properties
    
    public var completion: (([String: String]) -> Void)?
    
    public let spinner = JGProgressHUD()
    
    public var users = [[String: String]]()
    public var results = [[String: String]]()
    
    public var hasFetched = false
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        
        return searchBar
    }()
    
    public let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    public let noResultsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setupDelegates()
        
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        view.addSubview(noResultsLabel)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsLabel.heightAnchor.constraint(equalToConstant: 40),
            noResultsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noResultsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Selectors
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
