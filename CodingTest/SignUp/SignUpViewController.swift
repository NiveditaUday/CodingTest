//
//  SignUpViewController.swift
//  CodingTest
//
//  Created by user on 11/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol SignUpViewControllerProtocol : BaseViewControllerProtocol {
    func processSuccess()
    func processFailure(errcode: String)
    func handleErrors(error: NSError)
    
}


class SignUpViewController: BaseViewController, SignUpViewControllerProtocol, UITextFieldDelegate {
    
    @IBOutlet weak var dissmissBtn: UIButton!
    @IBOutlet weak var emailTxtField: BottomBorderTextField!
    @IBOutlet weak var confirmPwdTxtField: BottomBorderTextField!
    @IBOutlet weak var passwordTxtField: BottomBorderTextField!
    
    var signUpDelegate: SignUpDelegate = SignUpDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signUpDelegate.viewController = self
        
        self.dissmissBtn.layer.cornerRadius = 0.5 * self.dissmissBtn.bounds.size.width
        self.dissmissBtn.clipsToBounds = true
        
    }
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doRegister(_ sender: Any) {
        if self.validate() {
            showProgress()
            self.signUpDelegate.doRegister(eMail: self.emailTxtField.text!, password: passwordTxtField.text!)
        }
    }
    
    func validate() -> Bool {
        var valid : Bool = true
        
        if self.emailTxtField.text!.isEmpty {
            self.emailTxtField.attributedPlaceholder = fieldError(forKey: "Please enter User Name")
            valid = false
        }
        if self.passwordTxtField.text!.isEmpty {
            self.passwordTxtField.attributedPlaceholder = fieldError(forKey: "Please enter Password")
            valid = false
        }
        if self.confirmPwdTxtField.text!.isEmpty {
            self.confirmPwdTxtField.attributedPlaceholder = fieldError(forKey: "Please enter Password")
            valid = false
        }
        else if self.confirmPwdTxtField.text != self.passwordTxtField.text {
            valid = false
            self.alertView(title: "Error", message: "Both Passwords not matching. Please try again")
        }
        return valid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        if textField == self.emailTxtField {
            self.passwordTxtField.becomeFirstResponder()
        }
        else if textField == self.passwordTxtField {
            self.confirmPwdTxtField.becomeFirstResponder()
        }
        else if textField == self.confirmPwdTxtField {
            if self.validate() {
                showProgress()
                self.signUpDelegate.doRegister(eMail: self.emailTxtField.text!, password: passwordTxtField.text!)
            }
        }
        return true
    }
    
    func processSuccess() {
        self.hideProgress()
        self.dismiss(animated: true, completion: nil)
    }
    
    func processFailure(errcode: String) {
        self.hideProgress()
        alertView(title: "Error", message: errcode)
    }
    
    func handleErrors(error: NSError) {
        self.hideProgress()
        if let errorString  = error.userInfo["description"] as? String {
            alertView(title: "Error", message: errorString)
        }
        else{
            alertView(title: "Error", message: "Something went wrong. Please try again.")
        }
    }

}
