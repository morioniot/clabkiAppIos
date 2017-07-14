//
//  AppDelegate.swift
//  Clabki_v0.0
//
//  Created by Nicolás Fernández on 28/06/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, CBCentralManagerDelegate {
    
    var window: UIWindow?
    let notification = LocalNotification()
    let locationManager = CLLocationManager()
    var centralManager: CBCentralManager!
    
    
    //MARK: CENTRAL MANAJER LAUNCHER AND PERMISSION VERIFICATION
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        configureCentralManagerObject();
        if(launchOptions == nil){
            if #available(iOS 10.0, *) {
                notification.configureNotifications()
            }
            
            // Checking authorization CORE LOCATION permissions status
            if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways) {
                locationManager.requestAlwaysAuthorization();
            }
        }
        return true
    }
    
    func configureCentralManagerObject(){
        self.locationManager.delegate = self
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionRestoreIdentifierKey : Device.centralRestoreIdentifier])
    }
    

    
    //MARK: CORELOCATION METHODS DELEGATE
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("*** DID UPDATE LOCATIONS EVENTS ***")
        notification.presentLocalNotification(message: "DID UPDATE LOCATIONS")
    }

    //MARK: COREBLUETOOTH METHODS DELEGATE
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        //MARK: CHECKING BLUETOOTH ADAPTER STATUS
        if(central.state != .poweredOn){
            notification.presentLocalNotification(message: "Enciende tu bluetooth para ayudar a mascotas perdidas a encontrar su hogar :)")
        }
        else{
            locationManager.startMonitoringSignificantLocationChanges()
            centralManager.scanForPeripherals(withServices: [CBUUID.init(string: Device.clabki_service_uuid)], options: nil )
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Did Discover a Peripheral")
        notification.presentLocalNotification(message: "Una mascota Clabki está cerca de ti")
        let beacon = BeaconDataExtractor()
        let beaconAttributes = beacon.getData(advertisementData: advertisementData)
        let pet = Pet()
        pet.requestInfo(beaconAttributes: beaconAttributes){
            (response) in
            if(pet.reported_as_lost){
                let latitude  = self.locationManager.location?.coordinate.latitude
                let longitude = self.locationManager.location?.coordinate.longitude
                pet.addLocation(latitude: latitude!, longitude: longitude!){
                    (response) in
                        print(response)
                }
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        notification.presentLocalNotification(message: "Will Restore State Method :o :o :o :o")
    }
    //** ****************************** //////
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}




