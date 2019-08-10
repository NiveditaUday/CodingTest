//
//  CreateBookRest.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper


class CreateBookRest : NSObject {
    
    func createBook(bookDetails: CreateBookModel, delegate : RestDelegate) {
        
        let action = "api/book"

        
        HttpClient.sharedInstance.request(action: action, imethod: .post, mappable: bookDetails ) {
            response, error in
            
            if error == nil {
                if let loginResponse = Mapper<LoginResponseModel>().map(JSONObject: response) {
                    delegate.success(response: loginResponse)
                }
                else {
                    // something happened with the mapping
                    let nsError = NSError(domain: "Mapping error", code: 255, userInfo: ["":""])
                    delegate.fail(error: nsError)
                }
            }
            else {
                let nsError = error! as NSError
                delegate.fail(error: nsError)
            }
        }
        
    }
    
    
}
