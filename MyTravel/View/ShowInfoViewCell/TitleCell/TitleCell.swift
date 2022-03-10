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
        
        //修改第一個字的顏色
        let butedString = NSMutableAttributedString(string: title)
        butedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.brown, range: NSRange(location: 0, length: 1))
        cellTitleLabel.attributedText = butedString
    }
}
