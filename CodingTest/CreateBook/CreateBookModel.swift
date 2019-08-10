//
//  CreateBookModel.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateBookModel: NSObject, Mappable {
    var isbn: String?
    var title: String?
    var author: String?
    var publisher: String?
    var image: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    
    func mapping(map : Map) {
        isbn           <- map["isbn"]
        title          <- map["title"]
        author         <- map["author"]
        publisher      <- map["publisher"]
        image          <- map["image"]
    }
    
}
