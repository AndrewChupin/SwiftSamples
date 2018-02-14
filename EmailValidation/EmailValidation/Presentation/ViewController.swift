//
//  ViewController.swift
//  EmailValidation
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var constraintBottomCheck: NSLayoutConstraint!
    
    private let loginValidator = LoginValidator()
    
    
    override func viewDidLoad() {
        // Sorry for this
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tfLogin.becomeFirstResponder()
    }
    

    @IBAction func onCheckButtonClick(_ sender: Any) {
        guard let login = tfLogin.text else {
            tfLogin.backgroundColor = UIColor.red.withAlphaComponent(0.1)
            return
        }
        
        let isValid = loginValidator.validate(value: login)
        if isValid {
            tfLogin.backgroundColor = UIColor.green.withAlphaComponent(0.1)
        } else {
            tfLogin.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        }
        
    }
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            let kFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
            self.constraintBottomCheck.constant = kFrame
        }
    }
    
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.constraintBottomCheck.constant = 0
    }
    
}

