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
    @IBOutlet weak var registerStackView: UIStackView!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    @IBOutlet weak var validEmailLabel: UILabel!
    @IBOutlet weak var invalidPasswordLabel: UILabel!
    @IBOutlet weak var validPasswordLabel: UILabel!
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.emailTextField.becomeFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func backButtonPressed(_ sender: UIButton) {
        clearTextFields()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
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
        guard let confirmedPassword = passwordTextField.text else {
            showMissingFieldAlert("I don't think your password was confirmed.")
            return
        }
        if confirmedPassword != password {
            showMissingFieldAlert("I didn't find that the passwords you entered matched.")
            return
        }
//        AppSettings.displayName = name
//        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: nil)
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        guard let emailAddress = sender.text else {
            return
        }
        
        let isValidEmail = RegisterValidator.isValidEmail(emailAddress)
        
        hideOrShowValidationLabels(forResult: isValidEmail, invalidLabel: self.invalidEmailLabel, validLabel: self.validEmailLabel)
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        guard let password = sender.text else {
            return
        }
        
        let isValidPassword = RegisterValidator.isValidPassword(password)
        
        hideOrShowValidationLabels(forResult: isValidPassword, invalidLabel: self.invalidPasswordLabel, validLabel: self.validPasswordLabel)
    }
    
    // MARK: - Helper methods
    private func clearTextFields() {
        emailTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
    }
    
    private func hideOrShowValidationLabels(forResult isValid: Bool, invalidLabel: UILabel, validLabel: UILabel) {
        if isValid && validLabel.alpha != 1 {
            animateAlphaChanges(toHide: invalidLabel, toShow: validLabel)
        } else if invalidLabel.alpha != 1 {
            animateAlphaChanges(toHide: validLabel, toShow: invalidLabel)
        }
    }
    
    private func animateAlphaChanges(toHide x: UILabel, toShow y: UILabel) {
        if x.alpha == 1 {
            x.animateAlphaChange(to: 0)
        }
        y.animateAlphaChange(to: 1)
    }
    
    private func showMissingFieldAlert(_ message: String) {
        print("showMissingFieldAlert")
        let alert = UIAlertController(title: "There was an error validating the form", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
