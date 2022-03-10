//
//  ShowInfoViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/8.
// 展示點選到的景點內容

enum CellSelect: Int, CaseIterable {
    case image = 0, title = 1
}

import UIKit

class ShowInfoViewController: UIViewController {
    
    @IBOutlet weak var topView: TopBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var areaData: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp()
        
    }
    
    private func uiSetUp() {
        topView.setTitle(title: "景點介紹")
        topView.leftButtonSetup(imageName: "backArrowBlack") {
            self.navigationController?.popViewController(animated: true)
        }
        
        tableViewUiSetUp()
    }
    
}

extension ShowInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableViewUiSetUp() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.creatCell(nibName: "\(ImageCell.self)")
        tableView.creatCell(nibName: "\(TitleCell.self)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CellSelect.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cellItem = CellSelect(rawValue: indexPath.row) else {return UITableViewCell()}
        
        switch cellItem {
        case .image:
            
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "\(ImageCell.self)") as? ImageCell else {
                print("\(ShowInfoViewController.self) get imageCell fail")
                return UITableViewCell()
            }
            
            if let imageUrl = areaData?.picture1 {
                imageCell.convertCell(data: imageUrl)
            } else {
                print("\(ShowInfoViewController.self) get imageUrl fail")
            }
            
            return imageCell
            
        case .title:
            guard let titleCell = tableView.dequeueReusableCell(withIdentifier: "\(TitleCell.self)") as? TitleCell else {
                print("\(ShowInfoViewController.self) get titleCell fail")
                return UITableViewCell()
            }
            
            if let title = areaData?.name {
                titleCell.convertCell(title: title)
            } else {
                print("\(ShowInfoViewController.self) get title fail")
            }
            
            return titleCell
        }
        
    }
}
