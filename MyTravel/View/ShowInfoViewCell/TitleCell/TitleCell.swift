//
//  TitleCell.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/10.
// 顯示抬頭文字

import UIKit

class TitleCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    func convertCell(title: String) {
        cellTitleLabel.text = title
    }
}
