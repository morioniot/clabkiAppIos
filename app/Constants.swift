//
//  device.swift
//  Clabki_v0.0
//
//  Created by Nicolás Fernández on 28/06/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation

struct Device {
    
    //Mark: UUIDs
    static let clabki_service_uuid = "CABB"
    
    //Mark: Restore and Preservation
    static let centralRestoreIdentifier = "clabkiCentralManager"
    
}

struct RequestUrls{

    static let  getPetInfo   = "http://clabkiapi-morion.rhcloud.com/api/getStatus"
    static let  addPetLocation = "http://clabkiapi-morion.rhcloud.com/api/addLocationToPet"
    
}
