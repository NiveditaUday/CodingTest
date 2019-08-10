//
//  File.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponseModel: NSObject, Mappable {
    var token: String?
    var success: Int?
    var msg: String?
    
    
    required init?(map: Map) {}
    
    func mapping(map : Map) {
        token           <- map["token"]
        success         <- map["success"]
        msg             <- map["msg"]
    }
    
}
