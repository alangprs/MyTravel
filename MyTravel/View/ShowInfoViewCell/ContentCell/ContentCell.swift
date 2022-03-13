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
    
    var didClickUnfoldButton: (() -> Void)?
    var isSelect = true
    
    func convertCell(toldescribeText: String) {
        toldescribeLabel.numberOfLines = 3
        toldescribeLabel.text = toldescribeText
    }
    
    @IBAction func clikckUnfoldButton(_ sender: UIButton) {
        isSelect.toggle()
        
        if isSelect {
            toldescribeLabel.numberOfLines = 3
            unfoldButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
            
        } else {
            toldescribeLabel.numberOfLines = 0
            unfoldButton.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
        }
        didClickUnfoldButton?()
    }
}
