//
//  ViewController.swift
//  BookMyFlight
//
//  Created by Ankita Pabbi on 2020-08-25.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

struct Response: Codable {
    let result: MyResult
    let status: String
}
struct MyResult: Codable {
    
}

class ViewController: UIViewController {
    
    let URL_FOR_AIRPORT_CODES_API = "https://www.air-port-codes.com/api/v1/autocomplete"
    let API_KEY = "f2ef71dfd4"
    let API_SECRET = "3245382b046be2b"

    @IBAction func originSearch(_ sender: Any) {
        
        
        
    }
    @IBAction func destinationSearch(_ sender: Any) {
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/UK/GBP/en-GB/"
        let key = "873934a41bmsh2a18609f5f507bbp19db58jsn8266c732e0c6"
        
        let header = ["x-rapidapi-host": "skyscanner-skyscanner-flight-search-v1.p.rapidapi.com",
                      "x-rapidapi-key": "873934a41bmsh2a18609f5f507bbp19db58jsn8266c732e0c6"]
        
        Alamofire.request(url, method: .get, headers: header).responseJSON(completionHandler: {response in
            
            if response.result.isSuccess{
                print("Got it ..")
                if let jsondata = response.result.value{
                    print("JSON: \(jsondata)")
                }
            } else {
                print("Alamofire error = \(String(describing: response.result.error))")
            }
        })
        
        
        
//        let url = "https://www.air-port-codes.com/api/v1/flights?access_key=2b164d9e1c51295076bf26764405f599"
//        let parameters = ["dep_iata":"toronto","arr_iata":"vancouver"]
//
//        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                print(response)
//                //to get status code
//                if let status = response.response?.statusCode {
//                    switch(status){
//                    case 201:
//                        print("example success")
//                    default:
//                        print("error with response status: \(status)")
//                    }
//                }
//                //to get JSON return value
//                if let result = response.result.value {
//                    let JSON = result as! NSDictionary
//                    print(JSON)
//                }
//
//        }
        
        
//
//        Alamofire.request(url).responseJSON {
//            // 1. store the data from the internet in the
//            // response variable
//            response in
//
//            // 2. get the data out of the variable
//            guard let apiData = response.result.value else {
//                print("Error getting data from the URL")
//                return
//            }
//
//            // OUTPUT the json response to the terminal
//            print(apiData)
//
//
////            // GET something out of the JSON response
////            let jsonResponse = JSON(apiData)
////            let sunriseTime = jsonResponse["data"]["flight_date"].string
////
////
////            print("Sunrise: \(sunriseTime)")
        
            
            
        }
        
    }
    




