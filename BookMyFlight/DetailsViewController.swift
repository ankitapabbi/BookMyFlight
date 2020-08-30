//
//  DetailsViewController.swift
//  BookMyFlight
//
//  Created by Ankita Pabbi on 2020-08-28.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import WatchConnectivity

class DetailsViewController: UIViewController , WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    

    
    @IBOutlet weak var airlineName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var currencyCode: UILabel!
    @IBOutlet weak var symbolUsed: UILabel!
    @IBOutlet weak var ammount: UILabel!
    @IBOutlet weak var countyOrigin: UILabel!
    @IBOutlet weak var cityOrigin: UILabel!
    @IBOutlet weak var cityName: UILabel!
    var theUrl : String?
    var indexNo : Int?

    var thenumber : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
           self.title = "Flight Details"
        if(WCSession.isSupported())
        {
            print("Phone SUpports WatchConnectivity")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else{
            print("Phone does not support Watch Connectivty")
        }

        if let numberIn = indexNo{
            thenumber = numberIn
        }
         if let url = theUrl {
            
        
        // Do any additional setup after loading the view.
        
        
        
        
        let key = "873934a41bmsh2a18609f5f507bbp19db58jsn8266c732e0c6"
        
        let header = ["x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
                      "x-rapidapi-key": key]
        let pollingParameters: Parameters = [
            "sortype" : "price",
            "sortorder" : "asc",
            "includeQuery" : false,
            "stops" : 2,
            "includeCurrencyLookup" : false,
            "includeBookingDetailsLink" : true
        ]
        
        Alamofire.request(url, method: .get, parameters: pollingParameters, encoding: URLEncoding.default, headers: header).responseJSON(completionHandler: {response in
            
            if response.result.isSuccess{
                print("Got it ..")
                if let jsondata = response.result.value{
                    print("JSON for DESC: \(jsondata)")
                    
                    let jsonResponse = JSON(jsondata)
                    let flightCount = jsonResponse["Carriers"].count
                  
                        print("Name: \(jsonResponse["Carriers"][self.thenumber!]["Name"])")
                        print("ID: \(jsonResponse["Carriers"][self.thenumber!]["CarrierId"])")
                     print("Country Name: \(jsonResponse["Places"][0]["CountryName"])")
                    print("City Name: \(jsonResponse["Places"][0]["CityName"])")
                        print("Currency Code: \(jsonResponse["Currencies"][0]["Code"])")
                    print("Currency Symbol: \(jsonResponse["Currencies"][0]["Symbol"])")
                    print("Price: \(jsonResponse["Quotes"][0]["MinPrice"])")
                        
                       // self.names.append(jsonResponse["Carriers"][count]["Name"].string!)
                       // self.carrierID.append(jsonResponse["Carriers"][count]["CarrierId"].int!)
                        
                        
                        self.airlineName.text = jsonResponse["Carriers"][self.thenumber!]["Name"].string
                    self.countryName.text = jsonResponse["Places"][0]["CountryName"].string
                    self.cityName.text = jsonResponse["Places"][0]["CityName"].string
                    self.countyOrigin.text = jsonResponse["Places"][1]["CountryName"].string
                    self.cityOrigin.text = jsonResponse["Places"][1]["CityName"].string
                    self.currencyCode.text = jsonResponse["Currencies"][0]["Code"].string
                   self.symbolUsed.text = jsonResponse["Currencies"][0]["Symbol"].string
                    self.ammount.text = String(jsonResponse["Quotes"][0]["MinPrice"].int!)
                    
                        
                 
                  //  self.flightTable.reloadData()
                    
                    
                }
                
            } else {
                print("Alamofire error = \(String(describing: response.result.error))")
            }
            
            
        })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func bookFlightBtn(_ sender: Any) {
        
        var airName = self.airlineName.text!
        var origin = self.cityOrigin.text!
        var destination = self.cityName.text!
        var cost = self.ammount.text!
        
        var i = 0
        
        var cart = Cart(id: 0, airline: airName, origin: origin, destiation: destination, price: cost)
        Cart.clicked_flight.addFlight(cart: cart)
        print(Cart.clicked_flight.cart_array.count)
        i = i + 1
        
        if(WCSession.default.isReachable)
        {
            WCSession.default.sendMessage(["Airline":airName,"Origin":origin,"Destination":destination,"Price":cost], replyHandler: nil)
            // WCSession.default.sendMessage(["Result":result.text!], replyHandler: nil)
            //WCSession.default.sendMessage(["Gender":gender.titleForSegment(at: gender.selectedSegmentIndex)!], replyHandler: nil)
            
            
        }
        
        
    }
    
}
