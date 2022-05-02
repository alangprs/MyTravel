//
//  PhoneCell.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/5/2.
//

import UIKit

class PhoneCell: UITableViewCell {

    @IBOutlet weak var phonenumberLabel: UILabel!
    
    func convertCell(phoneNumber: String) {
        phonenumberLabel.text = phoneNumber
    }
    
}
