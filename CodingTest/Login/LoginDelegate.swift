//
//  LoginDelegate.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

protocol LoginDelegateProtocol : RestDelegate {
    func login(eMail : String, password: String)
}

class LoginDelegate: NSObject, LoginDelegateProtocol {
    
    var viewController : LoginViewControllerProtocol?
    
    override init() {}
    
    func login(eMail : String, password: String) {
        let loginParams = LoginModel()
        loginParams.username = eMail
        loginParams.password = password
        LoginRest().doLogin(loginParams: loginParams, delegate: self)
    }
    
    func success(response: Any!) {
        if let loginResponse = response as? LoginResponseModel
        {
            if let msg = loginResponse.msg
            {
                viewController?.processInvalidLogin(errcode: msg)
            }
            if let token = loginResponse.token {
                UserDefaults.standard.set(token, forKey: "token")
                viewController?.processLogin()
            }
        }
    }
    
    func fail(error: NSError) {
        UserDefaults.standard.set(nil, forKey: "token")
        viewController?.processLoginError(error: error)
    }
}
