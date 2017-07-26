//
//  getPetData.swift
//  app
//
//  Created by Nicolás Fernández on 14/07/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation
import CoreLocation


class Pet{
    
    var major:UInt16 = 0
    var minor:UInt16 = 0
    var reported_as_lost: Bool = false
    var latitude:  CLLocationDegrees = 0
    var longitude: CLLocationDegrees = 0
    
    func requestInfo(beaconAttributes: [String:UInt16], completeOnClosure:@escaping ([String:Any]) -> ()){
        let parameters = beaconAttributes
        let request = HttpRequestMaker()
        request.makeRequest(requestParameters: parameters, url: RequestUrls.getPetInfo){
            (response) in
                if(response["error"] == nil){
                    self.major = response["major"] as! UInt16
                    self.minor = response["minor"] as! UInt16
                    self.reported_as_lost = response["reported_as_lost"] as! Bool
                }
                completeOnClosure(response)
                return 
        }
    }
    
    func addLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completeOnClosure:@escaping ([String:Any]) -> ()){
        self.latitude  = latitude
        self.longitude = longitude
        let parameters: [String:Any] = ["major": major, "minor": minor, "lat":latitude, "lon": longitude]
        let request = HttpRequestMaker()
        request.makeRequest(requestParameters: parameters, url: RequestUrls.addPetLocation){
            (response) in
            completeOnClosure(response)
            return
        }
    }
}
