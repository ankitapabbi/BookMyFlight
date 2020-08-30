//
//  NotificationController.swift
//  BookMyFlight WatchKit Extension
//
//  Created by Ankita Pabbi on 2020-08-25.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class NotificationController: WKUserNotificationInterfaceController {

   
    @IBOutlet weak var airlineName: WKInterfaceLabel!
    override init() {
        // Initialize variables here.
        super.init()
       //self.airlineName.setText("airline name")
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    // 1
    override func didReceive(_ notification: UNNotification,
                             withCompletion completionHandler:
        @escaping (WKUserNotificationInterfaceType) -> Void) {
        // 2
    
     //   self.airlineName.setText("airline name")
      
        // 4
        completionHandler(.custom)
    }
}
