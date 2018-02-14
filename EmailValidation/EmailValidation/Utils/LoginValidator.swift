//
//  LoginValidator.swift
//  EmailValidation
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//

import Foundation

protocol Validator {
    associatedtype ValidateType
    func validate(value: ValidateType?) -> Bool
}

class LoginValidator: Validator {
    
    typealias ValidateType = String
    
    func validate(value login: ValidateType?) -> Bool {
        if let validLogin = login,
            isValidEmail(by: validLogin) || isValidName(by: validLogin) {
            return true
        } else {
            return false
        }
    }
    
    
    //
    //
    // REGEX: first - [a-z] or [A-Z]
    // REGEX: first ... @ - [a-z], [A-Z], [0-9], [.] or [-]
    // REGEX: @ ... . - [a-z], [A-Z], [0-9], [.] or [-]
    // REGEX: other - [a-z] or [A-Z]
    //
    // return false if email have't length from 5 to 32 or not valid to regex
    private func isValidEmail(by email: String) -> Bool {
        guard email.count > 5, email.count < 33 else {
            return false
        }
        
        let latinBlock = "[A-Za-z]"
        let anythingBlock = "[A-Za-z0-9\\.\\-]"
        let emailRegex = "^\(latinBlock){1}\(anythingBlock)*?\\@\(anythingBlock)+?\\.[A-Za-z]{2,}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    
    //
    //
    // REGEX: first - symbol must be [a-z] or [A-Z]
    // REGEX: other - Next from 2 to 31 symbol must be [a-z], [A-Z], [0-9], [.] or [-]
    //
    // return false if name not valid to regex
    private func isValidName(by name: String) -> Bool {
        let nameRegex = "^[a-zA-Z]{1}[A-Za-z0-9\\.\\-]{2,31}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return emailTest.evaluate(with: name)
    }
    
}

