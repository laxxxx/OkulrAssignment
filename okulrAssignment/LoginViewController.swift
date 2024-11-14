//
//  LoginPageViewController.swift
//  okulrAssignment
//
//  Created by Sree Lakshman on 14/11/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let username = self.usernameTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
//         Mock API Call
        if username == "test@gmail.com" && password == "password" {
            navigateToRegistration()
        } else {
            showAlert(message: "Invalid credentials")
        }
    }
    
    func navigateToRegistration() {
        let registrationVC = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

//MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTextField {
            self.usernameTextField.resignFirstResponder()
        } else  {
            self.passwordTextField.resignFirstResponder()
        }
        return true
        
    }
}


