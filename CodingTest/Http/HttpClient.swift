//
//  HttpClient.swift
//  CodingTest
//
//  Created by user on 10/08/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import ObjectMapper

class HttpClient : NSObject{
    let BASE_URL: String = "http://13.70.7.71:8080/"
    
    static let sharedInstance : HttpClient = HttpClient()
    var alamoFireManager = Alamofire.SessionManager.default
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // -- in sec
        configuration.timeoutIntervalForResource = 60 // -- in sec
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        self.alamoFireManager.adapter = HeadersAdapter()
    }
    
    func request(action : String, imethod: HTTPMethod? = .get, completionHandler: @escaping (_ response: AnyObject?, _ error: NSError?) -> ()) {
        let sUrl = BASE_URL + action
        self.alamoFireManager.request(sUrl, method : imethod!).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                completionHandler(JSON as AnyObject, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
        
    }
    
    
    func request(action : String, imethod: HTTPMethod? = .get, parameters:Dictionary<String, String>,
                 completionHandler: @escaping (_ response: AnyObject?, _ error: NSError?) -> ()) {
        var op :String = "?"
        var part : String = ""
        for (key, value) in parameters {
            part = part.appending(op)
            part = part.appendingFormat("%@=%@", key, value)
            op = "&"
        }
        
        // convert anything not web friendly
        part = part.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let sUrl = BASE_URL + action + part
        
        self.alamoFireManager.request(sUrl, method : imethod!).validate().responseJSON { response in
            switch response.result {
            case .success(let JSON):
                completionHandler(JSON as AnyObject?, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError)
            }
            
        }
        
    }
    
    func request(action : String, imethod: HTTPMethod? = .get, mappable: Mappable,
                 completionHandler: @escaping (_ response: AnyObject?, _ error: NSError?) -> ()) {
        let json = mappable.toJSON()
        let sUrl = BASE_URL + action
        
        self.alamoFireManager.request(sUrl, method : imethod!, parameters: json, encoding: JSONEncoding.default).validate().responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                
                completionHandler(JSON as? NSDictionary, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil, error as NSError)
            }
        }
        
    }
    
    func requestImage(path: String, completionHandler: @escaping (UIImage) -> Void){
        self.alamoFireManager.request("\(path)").responseImage(imageScale: 1.5, inflateResponseImage: false, completionHandler: {response in
            guard let image = response.result.value else{
                return
            }
            DispatchQueue.main.async {
                completionHandler(image)
            }
        })
    }
}
