//
//  ProfileHeaderView.swift
//  Messenger
//
//  Created by Igor Manakov on 20.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    // MARK: - Properties
    
    private let userAvatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Grom Gerenshtein"
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "sjkadfjka@gmail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        addSubview(userAvatarView)
        addSubview(nameLabel)
        addSubview(emailLabel)
        
        setProfileView()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            userAvatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            userAvatarView.heightAnchor.constraint(equalToConstant: 100),
            userAvatarView.widthAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: userAvatarView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            emailLabel.topAnchor.constraint(equalTo: userAvatarView.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Methods
    
    private func setProfileView() -> Void {
        
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let fileName = safeEmail + "_profile_picture.png"
        let path = "images/" + fileName
        
        StorageManager.shared.downloadURL(for: path) { [weak self] result in
            switch result {
            case .success(let url):
                self?.downloadImage(imageView: self!.userAvatarView, url: url)
            case .failure(let error):
                print("Failed to download url: \(error)")
            }
        }
    }
    
    private func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }.resume()
    }
}
