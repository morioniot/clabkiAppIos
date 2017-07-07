//
//  LocalNotifications.swift
//  app
//
//  Created by Nicolás Fernández on 7/07/17.
//  Copyright © 2017 Nicolás Fernández. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotification: NSObject, UNUserNotificationCenterDelegate{

    func configureNotifications(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self as? UNUserNotificationCenterDelegate
        center.requestAuthorization(options: [.alert, .sound]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
        }
    }
    
    
    func presentLocalNotification(message: String){
        let date = Date();
        if #available(iOS 10.0, *) {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "CLABKI"
            notificationContent.subtitle = String(describing: date)
            notificationContent.body = message
            notificationContent.sound = UNNotificationSound.default()
            //Add Trigger
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval:0.01, repeats:false)
            
            //Create Notification Request
            let notificationRequest = UNNotificationRequest(identifier:"peripheral_found_notification", content: notificationContent, trigger: notificationTrigger)
            
            UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                if let error = error {
                    print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                }
            }
        }
    }
    
}


extension LocalNotification{
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        
        completionHandler([.alert, .sound])
    }
    
}
