//
//  BaseViewController.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol BaseViewControllerProtocol {
    func fieldError(forKey: String)  -> NSAttributedString
    func hideProgress()
    func showProgress()
}

class BaseViewController: UIViewController,BaseViewControllerProtocol {

    var loadingNotification = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func fieldError(forKey: String)  -> NSAttributedString {
        return NSAttributedString(string: forKey, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
    }
    
    func hideProgress() {
        loadingNotification.hide(animated: true)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showProgress() {
        loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true )
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading..."
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }

    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
