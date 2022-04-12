//
//  ViewControllerCell.swift
//  MyTravel
//
//  Created by will on 2022/1/25.
// MainViewControllerCell

import UIKit

class ViewControllerCell: UICollectionViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //賦予圓角
        containerView.layer.cornerRadius = 15
        backgroundColorView.layer.cornerRadius = 15
        photoImageView.layer.cornerRadius = 15
        
        //設定陰影位置
        containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        //陰影透明度
        containerView.layer.shadowOpacity = 1
        //隱影範圍
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowColor = UIColor.black.cgColor
        
        photoImageView.clipsToBounds = true
        
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
