//
//  LoginVC+TextField.swift
//  Messenger
//
//  Created by Igor Manakov on 14.03.2022.
//

import UIKit

extension LoginVC: UITextFieldDelegate {
    
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
