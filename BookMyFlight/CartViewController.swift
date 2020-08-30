//
//  CartViewController.swift
//  BookMyFlight
//
//  Created by Ankita Pabbi on 2020-08-29.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import UIKit
import WatchConnectivity

class CartViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, WCSessionDelegate{
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
 

    @IBOutlet weak var cartTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTbl.delegate = self
        self.cartTbl.dataSource = self
        self.cartTbl.reloadData()
        
        
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

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.cartTbl.reloadData()
       print(Cart.clicked_flight.cart_array.count)
    }
    // Number of Sections In Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.clicked_flight.cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartLayoutTableViewCell
        cell.airName?.text = Cart.clicked_flight.cart_array[indexPath.row].airline
        cell.originLbl?.text = Cart.clicked_flight.cart_array[indexPath.row].origin
        cell.destinationLbl?.text = Cart.clicked_flight.cart_array[indexPath.row].destination
        cell.costLbl.text = Cart.clicked_flight.cart_array[indexPath.row].price
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let flight = Cart.clicked_flight.cart_array[indexPath.row].airline
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view,
            actionPerformed: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "Delete Booking", message: "Are you sure you want to delete this booking : \(flight) ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                // Perform delete
                Cart.clicked_flight.deleteFlight(index: indexPath.row)
                //self.tblCart.reloadData()
                self.cartTbl.deleteRows(at: [indexPath], with: .automatic)
                //self.lblCartCount.text = String(Cart.clicked_book.cart_array.count)
                actionPerformed(true)
            }))
            self.present(alert,animated: true)
            
            
        }
        delete.image = UIImage(named: "deleteicon")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
