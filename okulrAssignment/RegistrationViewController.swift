//
//  RegistrationViewController.swift
//  okulrAssignment
//
//  Created by Sree Lakshman on 14/11/24.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var pinCodeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        self.pinCodeTextField.delegate = self
    }
    
    func validateInput() -> Bool {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            showAlert(message: "First Name cannot be empty.")
            return false
        }
        
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            showAlert(message: "Last Name cannot be empty.")
            return false
        }
        
        guard let phoneNumber = phoneNumberTextField.text, isValidPhoneNumber(phoneNumber) else {
            showAlert(message: "Please enter a valid phone number.")
            return false
        }
        
        guard let pinCode = pinCodeTextField.text, isValidPinCode(pinCode) else {
            showAlert(message: "Please enter a valid pin code.")
            return false
        }
        
        return true
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        // Simple phone number validation (10 digits)
        let phoneRegex = "^[0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    func isValidPinCode(_ pinCode: String) -> Bool {
        // Simple pin code validation (6 digits for Indian pin codes)
        let pinCodeRegex = "^[0-9]{6}$"
        let pinCodeTest = NSPredicate(format: "SELF MATCHES %@", pinCodeRegex)
        return pinCodeTest.evaluate(with: pinCode)
    }
    
    // MARK: - Navigation
    func navigateToNextScreen() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RegistrationStep2ViewController") as? RegistrationStep2ViewController else {
            return
        }
        
        // Pass data to ProfileViewController
        vc.firstName = firstNameTextField.text ?? ""
        vc.lastName = lastNameTextField.text ?? ""
        vc.phoneNumber = phoneNumberTextField.text ?? ""
        vc.pinCode = pinCodeTextField.text ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if validateInput() {
            navigateToNextScreen()
        }
    }
    
    // MARK: - Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.phoneNumberTextField.resignFirstResponder()
        self.pinCodeTextField.resignFirstResponder()
        return true
    }
}
