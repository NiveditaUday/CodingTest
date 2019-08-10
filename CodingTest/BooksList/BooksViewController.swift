//
//  HomeViewController.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

protocol BooksViewControllerProtocol : BaseViewControllerProtocol {
    func booksListResponse(booksList: [BooksResponseModel])
    func handleErrors(error: NSError)
    
}


class BooksViewController: BaseViewController, BooksViewControllerProtocol {

    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var addBookBtn: UIButton!
    
    var bookList : [BooksResponseModel] = []
    var booksDelegate : BooksDelegate = BooksDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.booksDelegate.viewController = self
        
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.booksTableView.register(nib, forCellReuseIdentifier: "BookTableViewCell")
        self.booksTableView.rowHeight = UITableView.automaticDimension
        self.booksTableView.estimatedRowHeight = 200
        
        self.addBookBtn.layer.cornerRadius = 0.5 * self.addBookBtn.bounds.size.width
        self.addBookBtn.clipsToBounds = true
        
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showProgress()
        self.booksDelegate.getBooksList()
    }
    
    func booksListResponse(booksList: [BooksResponseModel])
    {
        self.hideProgress()
        self.bookList = booksList
        self.booksTableView.reloadData()
        
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

extension BooksViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.booksTableView.dequeueReusableCell(withIdentifier: "BookTableViewCell")! as! BookTableViewCell
        cell.selectionStyle = .none
        
        
        let booksDetails: BooksResponseModel = self.bookList[indexPath.row]

        cell.titleLbl.text = booksDetails.title
        cell.authorLbl.text = booksDetails.author
        
        if let img = booksDetails.image{
        HttpClient.sharedInstance.requestImage(path: img, completionHandler: {image in
            cell.imgView.image = image
        })
        }
        return cell
        
    }
    
}
