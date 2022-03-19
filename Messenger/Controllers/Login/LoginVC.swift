//
//  LoginViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LoginVC: UIViewController {
    
    // MARK: - Properties
    
    let spinner = JGProgressHUD(style: .dark)
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.placeholder = "Email"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setupDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        title = "Login"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        scrollView.contentOffset = .zero
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(loginButton)
        contentView.addSubview(forgetPasswordButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            emailField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            emailField.heightAnchor.constraint(equalToConstant: 40),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            forgetPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            forgetPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            forgetPasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            forgetPasswordButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func setupDelegate() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    // MARK: - Selectors
    
    @objc func loginButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        
        spinner.show(in: view)
        
        // Firebase Log In
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.spinner.dismiss()
            }
            
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            
            UserDefaults.standard.set(email, forKey: "email")
            
            print("Logged In User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func didTapRegister() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true) // Отправляем окно регистрации на nav
    }
    
    @objc func forgotPasswordTapped() {
        //such a pity
    }
    
    // MARK: - Methods
    
    func alertUserLoginError(message: String = "Please enter all information to create a new account.") {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
}
