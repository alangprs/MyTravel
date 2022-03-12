//
//  ContentCell.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/12.
// 顯示景點介紹內容

import UIKit

class ContentCell: UITableViewCell {
    @IBOutlet weak var toldescribeLabel: UILabel!
    @IBOutlet weak var unfoldButton: UIButton!
    
    func convertCell(toldescribeText: String) {
        toldescribeLabel.text = toldescribeText
    }
    
    @IBAction func clikckUnfoldButton(_ sender: UIButton) {
        
    }
}
