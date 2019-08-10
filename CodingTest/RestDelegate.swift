//
//  RestDelegate.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

protocol RestDelegate {
    
    func success(response: Any!)
    func fail(error: NSError)
    
}
