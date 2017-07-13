//
//  BeaconDataExtractor.swift
//  app
//
//  Created by Nicolás Fernández on 11/07/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation
import CoreBluetooth

class BeaconDataExtractor{

    func getData(advertisementData:[String: Any]) -> Dictionary<String, UInt16>{
        let result: Dictionary<String, UInt16>
        if let dataAttributes = advertisementData["kCBAdvDataServiceData"]! as? NSDictionary{
            if let bytes = dataAttributes[CBUUID.init(string: Device.clabki_service_uuid)]! as? Data{
                let major = UInt16(bytes[5]) + UInt16(bytes[4]) << 8
                let minor = UInt16(bytes[7]) + UInt16(bytes[6]) << 8
                result = ["major":major, "minor": minor]
                return result
            }
        }
        return [:]
    }

}
