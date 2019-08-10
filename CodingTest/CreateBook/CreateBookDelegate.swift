//
//  CreateBookDelegate.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
protocol CreateBookProtocol: RestDelegate {
    func createBook(bookDetails: CreateBookModel)
}

class CreateBookDelegate: NSObject, CreateBookProtocol {
    
    var viewController : CreateBookViewControllerProtocol?
    
    func createBook(bookDetails: CreateBookModel){
        CreateBookRest().createBook(bookDetails: bookDetails, delegate: self)
    }
    
    func success(response: Any!) {
        
        if let response = response as? LoginResponseModel
        {
            if let msg = response.msg
            {
                viewController?.processFailure(errcode: msg)
            }
            else if response.success == 1{
                viewController?.processSuccess()
            }
        }
    }
    
    func fail(error: NSError) {
        self.viewController?.handleErrors(error: error)
        
    }
    
}
