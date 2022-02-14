//
//  TouristAreaViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/2/13.
// 各地區景點展示

import UIKit

class TouristAreaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension TouristAreaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TouristAreaCell.self)", for: indexPath) as? TouristAreaCell else {
            print("TouristAreaViewController Get TouristAreaCell Fail")
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
