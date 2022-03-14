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

    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        
        return scrollView
    } ()
    
    private let imageView: UIImageView = { // Создание и настройка логотипа
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    } ()
    
    private let emailField: UITextField = { // Создание и настройка поля имейла
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.textColor = UIColor.white
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        //field.placeholder = "Email Address..."
        field.attributedPlaceholder = NSAttributedString(string: "Email Address...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .link
        
        return field
    } ()
    
    private let passwordField: UITextField = { // Создание и настройка поля пароля
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.textColor = UIColor.white
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 12
        field.layer.borderColor = UIColor.lightGray.cgColor
        //field.placeholder = "Password..."
        field.attributedPlaceholder = NSAttributedString(string: "Password...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .link
        field.isSecureTextEntry = true
        
        return field
    } ()
    
    private let loginButton: UIButton = { // Создание и настройка кнопки входа
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Login" // Заголовок нашего окна входа nav
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", // Cоздаем правую кнопку на верхней панели
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self,
                              action: #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self // настраиваем кнопку клавиатуры
        passwordField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        // scrollView.addSubview(spinner)
    }
    
    override func viewDidLayoutSubviews() { // Указываем размеры наших subviews, задаем их отступы
        super .viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                 height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        loginButton.frame = CGRect(x: 30,
                                     y: passwordField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
    }
    
    @objc private func loginButtonTapped() {
        
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
        
        
    
    func alertUserLoginError(message: String = "Please enter all information to create a new account.") {
        let alert = UIAlertController(title: "Woops",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterVC() // Создаем ViewController для окна регистрации
        vc.title = "Create account" // Заголовок нашего окна регистрации vc
        navigationController?.pushViewController(vc, animated: true) // Отправляем окно регистрации на nav
    }
    
}

extension LoginVC: UITextFieldDelegate { // Кнопки continue, done клавиатуры начинают работать правильно
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
    
}
