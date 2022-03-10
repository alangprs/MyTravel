//
//  UItableView.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/10.
//

import UIKit

extension UITableView {
    
    ///加入nib檔案
    func creatCell(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
}
