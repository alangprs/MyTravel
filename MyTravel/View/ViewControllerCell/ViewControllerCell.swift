//
//  ViewControllerCell.swift
//  MyTravel
//
//  Created by will on 2022/1/25.
// MainViewControllerCell

import UIKit

class ViewControllerCell: UICollectionViewCell {

    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.brown
        //賦予圓角
        self.layer.cornerRadius = 15
        //設定陰影位置
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        //陰影透明度
        self.layer.shadowOpacity = 0.7
        //隱影範圍
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.clipsToBounds = false
        
    }
    
    ///給予cell資料
    func convertCell(data: Any) {
        
        //記得把data 轉型內容改成 str資料
        guard let data = data as? RegionSelect else {
            print("ViewControllerCell convertCell get photoName fail")
            return
        }
        
        titleLabel.text = data.titleString
        
    }

}
