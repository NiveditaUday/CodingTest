//
//  LoginModel.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginModel: NSObject, Mappable {
    var username: String?
    var password: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map : Map) {
        username           <- map["username"]
        password         <- map["password"]
    }
    
}
