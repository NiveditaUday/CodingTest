//
//  BooksResponseModel.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import ObjectMapper

class BooksResponseModel: NSObject, Mappable {
    var _id: String?
    var isbn: String?
    var title: String?
    var author: String?
    var publisher: String?
    var image: String?
    var __v: Int?
    
    
    required init?(map: Map) {}
    
    func mapping(map : Map) {
        _id             <- map["_id"]
        isbn            <- map["isbn"]
        title           <- map["title"]
        author          <- map["author"]
        publisher       <- map["publisher"]
        image           <- map["image"]
        __v             <- map["__v"]
    }
    
}
