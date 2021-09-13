//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Igor Manakov on 13.09.2021.
//

import UIKit

class RegisterViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        
        return scrollView
    } ()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .gray
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    } ()
    
    let firstNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.placeholder = "First Name..."
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 12
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    } ()
    
    let lastNameField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.placeholder = "Last Name Address..."
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 12
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    } ()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.placeholder = "Email Address..."
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 12
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    } ()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.placeholder = "Password..."
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.cornerRadius = 12
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        
        return field
    } ()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        
        title = "Register"
        
        registerButton.addTarget(self,
                                 action: #selector(registerButtonTapped),
                                 for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
    
    }
    
    @objc private func didTapChangeProfilePic() {
        print("Change pic called")
    }
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                  y: 20,
                                  width: size,
                                  height: size)
        
        firstNameField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 20,
                                      width: scrollView.width - 60,
                                      height: 52)
        
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        
        registerButton.frame = CGRect(x: 30,
                                      y: passwordField.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)
        
    }
    
    @objc private func registerButtonTapped() {
        
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            alertUserRegisterError()
            return
        }
        
        // Firebase Sign Up
    }
    
    func alertUserRegisterError() {
        let alert = UIAlertController(title: "Woops",
                                     message: "Please enter all information to create a new account.",
                                     preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true)
    }
    
}

extension RegisterViewController: UITextFieldDelegate { // Кнопки continue, done клавиатуры начинают работать правильно
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        }
        else if textField == lastNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
    }
    
}
