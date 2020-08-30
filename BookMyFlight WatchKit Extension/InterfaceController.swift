//
//  InterfaceController.swift
//  BookMyFlight WatchKit Extension
//
//  Created by Ankita Pabbi on 2020-08-25.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController ,WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    

   
    var tableData = [""]
        //["Lufthansa","SpiceJet","Air France"]
    var origin = [""]
        //["Toronto","New Delhi","New York"]
    var destination = [""]
        //["New Delhi","Ahmedabad","Toronto"]
    var price = [""]
       // ["$ 666","$ 51","$ 198"]
    
    @IBOutlet weak var cartWatchTbl: WKInterfaceTable!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        loadTableData()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        WKInterfaceDevice().play(.click)
        
        print("WATCH: GOT A MESSAGE")
        
        self.tableData.append(message["Airline"]! as! String)
        self.origin.append(message["Origin"]! as! String)
        self.destination.append(message["Destination"]! as! String)
        self.price.append(message["Price"]! as! String)
      //  comments.setText("\(message["Comments"]!)")
      //  bmiValue.setText("\(message["Result"]!)")
        print("airline name\(message["Airline"]!)")
       
          loadTableData()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        loadTableData()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func loadTableData(){
        
        
        
        cartWatchTbl.setNumberOfRows(tableData.count, withRowType: "CartRowController")
        
        for( index, rowModel) in tableData.enumerated(){
            if let rowController = cartWatchTbl.rowController(at: index) as? CartRowController {
                rowController.airlineName.setText(rowModel)
            }
        }
        
        for( index, rowModel) in origin.enumerated(){
            if let rowController = cartWatchTbl.rowController(at: index) as? CartRowController {
                rowController.originName.setText(rowModel)
            }
        }
        
        for( index, rowModel) in destination.enumerated(){
            if let rowController = cartWatchTbl.rowController(at: index) as? CartRowController {
                rowController.desitnationName.setText(rowModel)
            }
        }
        
        for( index, rowModel) in price.enumerated(){
            if let rowController = cartWatchTbl.rowController(at: index) as? CartRowController {
                rowController.price.setText(rowModel)
            }
        }
        
    }

}
