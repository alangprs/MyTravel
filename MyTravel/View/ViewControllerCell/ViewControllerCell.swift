//
//  ViewControllerCell.swift
//  MyTravel
//
//  Created by will on 2022/1/25.
// MainViewControllerCell

import UIKit

class ViewControllerCell: UICollectionViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //賦予圓角
        containerView.layer.cornerRadius = 15
        photoImageView.layer.cornerRadius = 15
        
        
        //設定陰影位置
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        //陰影透明度
        shadowView.layer.shadowOpacity = 0.5
        //陰影範圍
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowColor = UIColor(named: "D26900-40")?.cgColor
        
        containerView.clipsToBounds = true
        shadowView.layer.cornerRadius = 15
    }
    
    ///給予cell資料
    func convertCell(data: Any, imageName: String) {
        
        //記得把data 轉型內容改成 str資料
        guard let data = data as? RegionSelect else {
            Logger.log(message: "get photoName fail")
            return
        }
        
        titleLabel.text = data.titleString
        photoImageView.image = UIImage(named: imageName)
        
    }

}
