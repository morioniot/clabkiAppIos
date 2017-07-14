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

    func makeRequest( requestParameters: Dictionary<String, Any>, url: String, completeOnClosure:@escaping ([String:Any]) -> ()) {
        let parameters: Parameters = requestParameters
        Alamofire.request(url,parameters: parameters)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    let responseError: [String:Any] = ["Error":(String(describing: response.result.error))]
                    completeOnClosure(responseError)
                    return
                }
                
                guard let response = response.result.value as? [String: Any] else {
                    let message = "Invalid tag information received from the service"
                    let responseError: [String:Any] = ["Error":message]
                    completeOnClosure(responseError)
                    return
                }
                
                completeOnClosure(response)
        }
    }
}

