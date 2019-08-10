//
//  CreateBookViewController.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol CreateBookViewControllerProtocol : BaseViewControllerProtocol {
    func processSuccess()
    func processFailure(errcode: String)
    func handleErrors(error: NSError)
    
}

class CreateBookViewController: BaseViewController, CreateBookViewControllerProtocol, UITextFieldDelegate {

    @IBOutlet weak var isbnTxtField: BottomBorderTextField!
    @IBOutlet weak var titleTxtField: BottomBorderTextField!
    @IBOutlet weak var authorTxtField: BottomBorderTextField!
    @IBOutlet weak var publisherTxtField: BottomBorderTextField!
    @IBOutlet weak var dismissBtn: UIButton!
    
    var bookDelegate: CreateBookDelegate = CreateBookDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookDelegate.viewController = self
        self.dismissBtn.layer.cornerRadius = 0.5 * self.dismissBtn.bounds.size.width
        self.dismissBtn.clipsToBounds = true
    }
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createBook(_ sender: Any) {
        if self.validate() {
            self.showProgress()
            let bookDetails = uploadData()
            self.bookDelegate.createBook(bookDetails: bookDetails)
        }
    }
    
    func uploadData() -> CreateBookModel {
        let bookDetails = CreateBookModel()
        bookDetails.isbn = self.isbnTxtField.text
        bookDetails.title = self.titleTxtField.text
        bookDetails.author = self.authorTxtField.text
        bookDetails.publisher = self.publisherTxtField.text
        bookDetails.image = "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg" // Statically adding url but instead we can go for imagepicker option
        return bookDetails
    }
    
    func validate() -> Bool {
        var valid : Bool = true
        
        if self.titleTxtField.text!.isEmpty {
            self.titleTxtField.attributedPlaceholder = fieldError(forKey: "Please enter book Title")
            valid = false
        }
        if self.authorTxtField.text!.isEmpty {
            self.authorTxtField.attributedPlaceholder = fieldError(forKey: "Please enter book Author")
            valid = false
        }
        return valid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        
        if textField == self.isbnTxtField {
            self.titleTxtField.becomeFirstResponder()
        }
        else if textField == self.titleTxtField {
            self.authorTxtField.becomeFirstResponder()
        }
        else if textField == self.authorTxtField {
            self.publisherTxtField.becomeFirstResponder()
        }
        else if textField == self.publisherTxtField {
            if self.validate() {
                self.showProgress()
                let bookDetails = uploadData()
                self.bookDelegate.createBook(bookDetails: bookDetails)
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
