//
//  getPetData.swift
//  app
//
//  Created by Nicolás Fernández on 14/07/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation


class Pet{
    
    var major:UInt16 = 0
    var minor:UInt16 = 0
    var reported_as_lost: Bool = false

    func requestInfo(beaconAttributes: [String:UInt16], completeOnClosure:@escaping ([String:Any]) -> ()){
        let parameters = beaconAttributes
        let request = HttpRequestMaker()
        request.makeRequest(requestParameters: parameters, url: RequestUrls.getPetInfo){
            (response) in
                self.major = response["major"] as! UInt16
                self.minor = response["minor"] as! UInt16
                self.reported_as_lost = response["reported_as_lost"] as! Bool
                completeOnClosure(response)
                return 
        }
    }
}
