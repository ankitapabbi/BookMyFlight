//
//  CartRowController.swift
//  BookMyFlight WatchKit Extension
//
//  Created by Ankita Pabbi on 2020-08-29.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import Foundation
import WatchKit

class CartRowController: NSObject{
    @IBOutlet weak var airlineName: WKInterfaceLabel!
    @IBOutlet weak var price: WKInterfaceLabel!
    
    @IBOutlet weak var desitnationName: WKInterfaceLabel!
    @IBOutlet weak var originName: WKInterfaceLabel!
}
