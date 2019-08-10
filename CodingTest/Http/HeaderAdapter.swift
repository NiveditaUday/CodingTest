//
//  HeaderAdapter.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Alamofire
import Reachability
import SystemConfiguration

class HeadersAdapter: RequestAdapter {
    
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var urlRequest = urlRequest
        
        if let token = UserDefaults.standard.object(forKey: "token") as? String {
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization" )
        }
       // urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
        
    }
    
}



