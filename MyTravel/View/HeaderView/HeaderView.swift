//
//  HeaderView.swift
//  MyTravel
//
//  Created by will on 2022/1/27.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    
    func headerViewUiSetup(data: Any) {
        titleLabel.text = data as? String
    }
    
}
