//
//  ViewController.swift
//  MyTravel
//
//  Created by will on 2022/1/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topBarView: TopBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarViewSetup()
    }
    
    func topBarViewSetup() {
        topBarView.setTitle(title: "首頁")
    }


}

