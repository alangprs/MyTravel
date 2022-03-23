//
//  TagCell.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/21.
//

import UIKit

class TagCell: UICollectionViewCell {

    @IBOutlet weak var tagTextLabel: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
        
        self.layer.cornerRadius = 15
    }
    
    func convertCell(data: String) {
        tagTextLabel.text = data
    }
}
