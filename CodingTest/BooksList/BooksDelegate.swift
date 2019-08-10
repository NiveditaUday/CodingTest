//
//  BooksDelegate.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

protocol BooksDelegateProtocol: RestDelegate {
    func getBooksList()
}

class BooksDelegate: NSObject, BooksDelegateProtocol {
    
    var viewController : BooksViewControllerProtocol?
    
    func getBooksList() {
        BooksRest().getBooksList(delegate: self)
    }
    
    func success(response: Any!) {
        if let booksList = response as? [BooksResponseModel] {
            self.viewController?.booksListResponse(booksList: booksList)
        }
    }
    
    func fail(error: NSError) {
        self.viewController?.handleErrors(error: error)
        
    }

}
