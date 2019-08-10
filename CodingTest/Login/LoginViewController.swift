//
//  ViewController.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol LoginViewControllerProtocol : BaseViewControllerProtocol {
    func processLogin()
    func processLoginError(error :  NSError)
    func processInvalidLogin(errcode: String)
}

class LoginViewController: BaseViewController, LoginViewControllerProtocol, UITextFieldDelegate {

    @IBOutlet weak var emailTxtField: BottomBorderTextField!
    @IBOutlet weak var passwordTextField: BottomBorderTextField!
    
    var loginDelegate : LoginDelegate = LoginDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loginDelegate.viewController = self
        UserDefaults.standard.set(nil, forKey: "token")
    }

    @IBAction func doLogin(_ sender: Any) {
        if self.validate() {
            showProgress()
            self.loginDelegate.login(eMail: self.emailTxtField.text!, password: self.passwordTextField.text!)
        }
    }
    
    func processLogin() {
        hideProgress()
        performSegue(withIdentifier: "booksView", sender: nil)
    }
    
    func processLoginError(error :  NSError) {
        hideProgress()
        if let errorString  = error.userInfo["description"] as? String {
            alertView(title: "Error", message: errorString)
        }
        else{
            alertView(title: "Error", message: "Something went wrong. Please try again.")
        }
    }
    
    
    func processInvalidLogin(errcode: String) {
        hideProgress()
        alertView(title: "Error", message: errcode)
    }
    
    
    func validate() -> Bool {
        var valid : Bool = true
        
        if self.emailTxtField.text!.isEmpty {
            self.emailTxtField.attributedPlaceholder = fieldError(forKey: "Please enter User Name")
            valid = false
        }
        if self.passwordTextField.text!.isEmpty {
            self.passwordTextField.attributedPlaceholder = fieldError(forKey: "Please enter Password")
            valid = false
        }
        return valid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        if textField == self.emailTxtField {
            self.passwordTextField.becomeFirstResponder()
        }
        else if textField == self.passwordTextField {
            if self.validate() {
                showProgress()
                self.loginDelegate.login(eMail: self.emailTxtField.text!, password: passwordTextField.text!)
            }
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event : UIEvent?) {
        self.view.endEditing(true)
    }
}
