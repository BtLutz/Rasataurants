//
//  LoginViewController.swift
//  Rasataurants
//
//  Created by Brian Lutz on 11/30/18.
//  Copyright © 2018 Gecko. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var logoBox: UIView!
    @IBOutlet var loginBox: UIView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.animateLogoView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - IBActions
    @IBAction func loginButtonPressed() {
        login()
    }
    
    @IBAction func registerButtonPressed() {
        let registerViewController = RegisterViewController(withUsername: usernameTextField.text, andPassword: passwordTextField.text)
//        let registerViewController = RegisterViewController()
        present(registerViewController, animated: true) {
            self.usernameTextField.text = registerViewController.emailTextField.text
            self.passwordTextField.text = registerViewController.passwordTextField.text
            self.login()
        }
    }
    
    // MARK: - Animations
    private func animateLogoView() {
        self.view.constraints.forEach { constraint in
            if constraint.identifier == "LogoBoxVerticalConstraint" || constraint.identifier == "LoginBoxVerticalConstraint" {
                constraint.constant -= 150
            }
        }
        UIView.animate(withDuration: 0.75, delay: 0.125, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    // MARK: - Helper methods
    private func login() {
        
    }
    
}
