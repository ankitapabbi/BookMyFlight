//
//  CartLayoutTableViewCell.swift
//  BookMyFlight
//
//  Created by Ankita Pabbi on 2020-08-29.
//  Copyright © 2020 Ankita Pabbi. All rights reserved.
//

import UIKit

class CartLayoutTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var airName: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
