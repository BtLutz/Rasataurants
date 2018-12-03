//
//  RegisterViewController.swift
//  Rasataurants
//
//  Created by Brian Lutz on 11/30/18.
//  Copyright © 2018 Gecko. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    // MARK: - Properties
    var givenEmail: String?
    var givenPassword: String?
    
    // MARK: - Initializers
    init(withUsername username: String?, andPassword password: String?) {
        self.givenEmail = username
        self.givenPassword = password
        super.init(nibName: "RegisterViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        self.emailTextField.text = givenEmail
        self.passwordTextField.text = givenPassword
        self.emailTextField.addTarget(self, action: #selector(emailTextFieldChanged(_:)), for: .editingDidEnd)
    }
    
    // MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        clearTextFields()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        print("register button pressed")
        guard let emailAddress = emailTextField.text,
            RegisterValidator.isValidEmail(emailAddress) else {
                // TODO: Turn this into an enumeration
                showMissingFieldAlert("There doesn't seem to be an email address.")
                return
        }
        guard let password = passwordTextField.text,
            RegisterValidator.isValidPassword(password) else {
                showMissingFieldAlert("Did you make sure to put in a password?")
                return
        }
        guard let confirmedPassword = passwordTextField.text,
            confirmedPassword == password else {
            showMissingFieldAlert("Does your confirmed password match your password?")
            return
        }
//        AppSettings.displayName = name
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: nil)
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        guard let emailAddress = emailTextField.text else {
            return
        }
        if !RegisterValidator.isValidEmail(emailAddress) {
            emailTextField.backgroundColor = UIColor(red: 255, green: 25, blue: 25, alpha: 0.3)
        } else {
            emailTextField.backgroundColor = nil
        }
    }
    
    // MARK: - Helper methods
    private func clearTextFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
    }
    
    private func showMissingFieldAlert(_ message: String) {
        print("showMissingFieldAlert")
        let alert = UIAlertController(title: "There was an error validating the form", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
