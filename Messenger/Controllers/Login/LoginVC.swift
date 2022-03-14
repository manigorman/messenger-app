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
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
//        field.layer.cornerRadius = 12
//        field.layer.borderWidth = 1
//        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.backgroundColor = .white
//        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
//        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
//        setConstraints()
        setupScrollView()
        contentView.backgroundColor = .purple
        setupDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        title = "Login" // Заголовок нашего окна входа nav
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", // Cоздаем правую кнопку на верхней панели
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(imageView)
//        contentView.addSubview(emailField)
//        contentView.addSubview(passwordField)
//        contentView.addSubview(loginButton)
    }
    
//    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//
//
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 100),
//            imageView.heightAnchor.constraint(equalToConstant: 100),
//
//            emailField.topAnchor.constraint(equalTo: imageView.bottomAnchor),
//            emailField.heightAnchor.constraint(equalToConstant: 20),
//            emailField.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
//            emailField.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
//
//            loginButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            loginButton.topAnchor.constraint(equalTo: emailField.bottomAnchor),
//            loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            loginButton.heightAnchor.constraint(equalToConstant: 20)
//        ])
//    }
//
    
    func setupScrollView(){
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           contentView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollView)
           scrollView.addSubview(contentView)
           
           scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
           scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           
           contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
           contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
           contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
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
        
        //        DatabaseManager.shared.userExists(with: email) { [weak self] exists in
        //            guard let strongSelf = self else {
        //                return
        //            }
        //
        //            guard !exists else {
        //                //user already exists
        //                strongSelf.alertUserLoginError(message: "Looks like a user account for that email address already exists.")
        //                return
        //            }
        
        
        spinner.show(in: view)
        
        // Firebase Log Inx
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
            print("Logged In User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    //    }
    
    @objc func didTapRegister() {
        let vc = RegisterVC() // Создаем ViewController для окна регистрации
        vc.title = "Create account" // Заголовок нашего окна регистрации vc
        navigationController?.pushViewController(vc, animated: true) // Отправляем окно регистрации на nav
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
