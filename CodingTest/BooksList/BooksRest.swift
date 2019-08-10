//
//  BooksRest.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

class BooksRest : NSObject {
    
    
    func getBooksList(delegate : RestDelegate) {
        let action = "api/book"

        HttpClient.sharedInstance.request(action: action, imethod: .get) {
            response, error in
            
            if error == nil {
                if let booksList:Array<BooksResponseModel> = Mapper<BooksResponseModel>().mapArray(JSONObject: response) {
                    delegate.success(response: booksList)
                }
                else {
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
