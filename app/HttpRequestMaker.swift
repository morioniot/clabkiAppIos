//
//  httpRequestMaker.swift
//  app
//
//  Created by Nicolás Fernández on 6/07/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpRequestMaker{

    func getPetStatus( requestParameters: Dictionary<String, UInt16>, completeOnClosure:@escaping (AnyObject?) -> ()) {
        let parameters: Parameters = requestParameters
        Alamofire.request("http://clabkiapi-morion.rhcloud.com/api/getStatus",parameters: parameters)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    let responseError: JSON = ["Error":(String(describing: response.result.error))]
                    completeOnClosure(responseError as AnyObject)
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

