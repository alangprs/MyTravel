//
//  TouristAreaViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/2/13.
// 各地區景點展示

import UIKit

class TouristAreaViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var areaData = [Info]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetup()
    }

}

extension TouristAreaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "\(TouristAreaCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(TouristAreaCell.self)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return areaData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TouristAreaCell.self)", for: indexPath) as? TouristAreaCell else {
            print("TouristAreaViewController Get TouristAreaCell Fail")
            return UITableViewCell()
        }
        
        cell.convertCell(data: areaData[indexPath.row])
        
        return cell
    }
    
    
}
