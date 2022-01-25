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
    
    
    ///給予cell資料
    func convertCell(data: Any) {
        
        //記得把data 轉型內容改成 str資料
        guard let photoName = data as? UIImage else {
            print("ViewControllerCell convertCell get photoName fail")
            return
        }
        guard let title = data as? String else {
            print("ViewControllerCell convertCell get title fail")
            return
        }
        
        photoImageView.image = photoName
        titleLabel.text = title
    }

}
