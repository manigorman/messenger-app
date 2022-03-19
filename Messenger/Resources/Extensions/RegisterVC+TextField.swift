//
//  RegisterVC+TextField.swift
//  Messenger
//
//  Created by Igor Manakov on 15.03.2022.
//

import UIKit

extension RegisterVC: UITextFieldDelegate {
    
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
