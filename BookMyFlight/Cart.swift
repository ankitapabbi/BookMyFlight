//
//  Cart.swift
//  BookMyFlight
//
//  Created by Ankita Pabbi on 2020-08-29.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import Foundation
class Cart {
    
    var id: Int
    var airline: String
    var origin: String
    var destination: String
    var price: String
    static var clicked_flight = Cart()
    static var cart_Dictionary = [Int:Cart]()
    var cart_array = Array<Cart>()
    
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
    func addFlight(cart : Cart) {
        cart_array.append(cart)
    }
    func deleteFlight(index : Int) {
        // WishList.wish_Dictionary.updateValue(book, forKey: Int(book.id)!)
        cart_array.remove(at: index)
    }
    
}
