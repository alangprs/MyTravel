//
//  ShowInfoViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/8.
// 展示點選到的景點內容

import UIKit

class ShowInfoViewController: UIViewController {
    
    @IBOutlet weak var topView: TopBarView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSetUp()
        
    }

    private func uiSetUp() {
        topView.setTitle(title: "景點介紹")
        topView.leftButtonSetup(imageName: "backArrowBlack") {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
