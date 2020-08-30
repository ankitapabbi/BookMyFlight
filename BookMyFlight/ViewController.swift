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

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var flightTable: UITableView!
    var names = [String]()
    var carrierID = [Int]()
    let datePicker = UIDatePicker()
    var urlToSend : String?
    
    
   
    
    
    @IBOutlet weak var navflight: UINavigationBar!
    
    @IBOutlet weak var originTextfield: UITextField!
    @IBOutlet weak var returnDate: UITextField!
    @IBOutlet weak var departureDate: UITextField!
    @IBOutlet weak var destinationTextfield: UITextField!
 
  
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.title = "Search Flights"
        self.flightTable.delegate = self
        self.flightTable.dataSource = self
        self.flightTable.reloadData()
        // Do any additional setup after loading the view.
        

            
            
        }
    override func viewWillAppear(_ animated: Bool) {
        
        self.flightTable.reloadData()
    }
    
    @IBAction func getFlights(_ sender: Any) {
        
       
        
        let origintext = self.originTextfield.text!
        let destinationtext = self.destinationTextfield.text!
        let departuredatetext = self.departureDate.text!
        let returndatetext = self.returnDate.text!
        
        
        //"https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/USD/en-US/YYZ-sky/DEL-sky/2020-09-01?inboundpartialdate=2020-12-01"
        
        
        let url = "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/USD/en-US/"+origintext+"-sky/"+destinationtext+"-sky/"+departuredatetext+"?inboundpartialdate="+returndatetext+""
        
        urlToSend = url
        
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
                    print("JSON: \(jsondata)")
                    
                    let jsonResponse = JSON(jsondata)
                    let flightCount = jsonResponse["Carriers"].count
                    self.names.removeAll()
                    self.carrierID.removeAll()
                    for count in 0 ..< flightCount {
                       
                        print("Name: \(jsonResponse["Carriers"][count]["Name"])")
                        print("ID: \(jsonResponse["Carriers"][count]["CarrierId"])")
                        
                        self.names.append(jsonResponse["Carriers"][count]["Name"].string!)
                        self.carrierID.append(jsonResponse["Carriers"][count]["CarrierId"].int!)
                        
                    }
                    self.flightTable.reloadData()
                    
                    
                }
                
            } else {
                print("Alamofire error = \(String(describing: response.result.error))")
            }
            
            
        })
        
        
    }
    
    @IBAction func gettingDepartureDate(_ sender: UITextField) {
        //Format Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        departureDate.inputAccessoryView = toolbar
        departureDate.inputView = datePicker
        
    }
    
    
    @IBAction func gettingReturnDate(_ sender: Any) {
        //Format Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker1));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        returnDate.inputAccessoryView = toolbar
        returnDate.inputView = datePicker
        
    }
    func setDatePicker() {
       
    }
    
    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        departureDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    @objc func doneDatePicker1(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        returnDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    // Number of Sections In Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: "flightcell") as! UITableViewCell
        //        //cell= self.book_array[indexPath.row].id
        cell.textLabel?.text = names[indexPath.row]
        cell.detailTextLabel?.text = "Carrier ID: "+String(carrierID[indexPath.row])
//        cell.imageView?.clipsToBounds = true
//        cell.imageView?.layer.masksToBounds = true
//        cell.imageView?.contentMode = .scaleAspectFit
//        cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.height)! / 4
                // click action on perticular customer name using tap gesture
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapToGoOnDesc(_:)))
                cell.tag = indexPath.row
                cell.addGestureRecognizer(tapGesture)
        
        return cell
        
    }
    @objc func tapToGoOnDesc(_ sender: UITapGestureRecognizer) {
        print(sender.view!.tag)// to display index
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let indexNo = sender.view!.tag
        let details = sb.instantiateViewController(withIdentifier: "futherDetails") as! DetailsViewController
        details.theUrl = urlToSend
        details.indexNo = indexNo
        
        self.navigationController?.pushViewController(details,animated: true)
        // to get perticular index
        //            Book.clicked_book = self.book_array[(sender.view?.tag)!]
        //            self.performSegue(withIdentifier: "goToSubCat", sender: nil)
        
    }
    
   
    
    }
    




