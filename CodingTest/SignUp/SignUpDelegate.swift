//
//  SignUpDelegate.swift
//  CodingTest
//
//  Created by user on 11/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

protocol SignUpDelegateProtocol : RestDelegate {
    func doRegister(eMail : String, password: String)
}

class SignUpDelegate: NSObject, SignUpDelegateProtocol {
    
    var viewController : SignUpViewControllerProtocol?
    
    override init() {}
    
    func doRegister(eMail : String, password: String) {
        let signupParams = LoginModel()
        signupParams.username = eMail
        signupParams.password = password
        SignUpRest().doRegister(signupParams: signupParams, delegate: self)
    }
    
    func success(response: Any!) {
        if let loginResponse = response as? LoginResponseModel
        {
            
            if loginResponse.success == 0, let msg = loginResponse.msg
            {
                viewController?.processFailure(errcode: msg)
            }
            else {
                viewController?.processSuccess()
            }
        }
    }
    
    func fail(error: NSError) {
        self.viewController?.handleErrors(error: error)
        
    }
}
