//
//  EmailValidator.swift
//  Rasataurants
//
//  Created by Brian Lutz on 12/1/18.
//  Copyright © 2018 Gecko. All rights reserved.
//

import Foundation

struct RegisterValidator {
    /// Validates whether the given string is an email address
    /// - parameter enteredEmail: The string you'd like to validate
    /// - returns: True if the string looks like an email, false if not
    static func isValidEmail(_ enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    /// Validates whether the given string fits our password criteria
    /// - parameter enteredPassword: The string you'd like to validate
    /// - returns: True if the password meets our stringent criteria, false if not
    static func isValidPassword(_ enteredPassword: String) -> Bool {
        return enteredPassword.count >= 6
    }
}
