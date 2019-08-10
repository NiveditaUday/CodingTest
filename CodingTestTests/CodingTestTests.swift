//
//  CodingTestTests.swift
//  CodingTestTests
//
//  Created by user on 08/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import XCTest
@testable import CodingTest

class CodingTestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPasswordMatch() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signup = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
         let _ = signup.view
        XCTAssertEqual(signup.passwordTxtField.text, signup.confirmPwdTxtField.text)
    }

    func testPasswordFieldSecureCheck() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login = storyboard.instantiateInitialViewController() as! LoginViewController
        let _ = login.view
        XCTAssertEqual(true, login.passwordTextField.isSecureTextEntry)
    }
    
    func testLoginDelegateValidation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login = storyboard.instantiateInitialViewController() as! LoginViewController
        let _ = login.view
        XCTAssertNotNil(login.loginDelegate)
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
