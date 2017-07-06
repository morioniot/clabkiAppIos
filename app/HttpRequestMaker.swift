//
//  httpRequestMaker.swift
//  app
//
//  Created by Nicolás Fernández on 6/07/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation
import Alamofire

class HttpRequestMaker{

    func getPetStatus(major: String, minor: String, completeOnClosure:@escaping (AnyObject?) -> ()) {
        let parameters: Parameters = ["major":major, "minor": minor]
        Alamofire.request("http://clabkiapi-morion.rhcloud.com/api/getStatus",parameters: parameters)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    completeOnClosure(response.result.error as AnyObject)
                    return
                }
                
                guard let responseJSON = response.result.value as? [String: Any] else {
                    let message = "Invalid tag information received from the service"
                    completeOnClosure(message as AnyObject)
                    return
                }
                
                completeOnClosure(responseJSON as AnyObject)
                
        }
    }
}

