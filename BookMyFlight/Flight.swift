//
//  Flight.swift
//  BookMyFlight
//
//  Created by Ankita Pabbi on 2020-08-29.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import Foundation
class Flight {
    
    var id: Int
    var airline: String
    var origin: String
    var destination: String
    var price: String
    static var clicked_flight = Flight()
    static var flight_Dictionary = [Int:Flight]()
    var flight_array = Array<Flight>()
    
    init(){
        self.id = Int()
        self.airline = String()
        self.origin = String()
        self.destination = String()
        self.price = String()
     
        
    }
    init(id: Int,airline: String,origin:String,destiation:String,price:String) {
        self.id = id
        self.airline = airline
        self.origin = origin
        self.destination = destiation
        self.price = price
       
    }
    func addBook(flight : Flight) {
        Flight.flight_Dictionary.updateValue(flight, forKey: flight.id)
    }
    
}



