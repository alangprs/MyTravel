//
//  ShowInfoViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/8.
// 展示點選到的景點內容

enum CellSelect: Int, CaseIterable {
    case image = 0, title = 1, content = 2, phoneNumber = 3
}

import UIKit

class ShowInfoViewController: UIViewController {
    
    deinit {
        print("ShowInfoViewController deinit")
    }
    
    @IBOutlet weak var topView: TopBarView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ShowInfoVM = {
        var vm = ShowInfoVM()
        return vm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    private func setupUI() {
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
        tableView.creatCell(nibName: "\(ContentCell.self)")
        tableView.creatCell(nibName: "\(PhoneCell.self)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CellSelect.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cellItem = CellSelect(rawValue: indexPath.row) else {return UITableViewCell()}
        
        let attractionsInfo = viewModel.getAttractionsInfo(indexPath: indexPath)
        
        switch cellItem {
        case .image:
            
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "\(ImageCell.self)") as? ImageCell else {
                print("\(ShowInfoViewController.self) get imageCell fail")
                return UITableViewCell()
            }
            
            if let imageUrl = attractionsInfo?.picture1 {
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
            
            if let title = attractionsInfo?.name {
                titleCell.convertCell(title: title)
            } else {
                print("\(ShowInfoViewController.self) get title fail")
            }
            
            return titleCell
        case .content:
            // 顯示內容cell
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: "\(ContentCell.self)") as? ContentCell else {
                print("\(ShowInfoViewController.self) get content fail")
                return UITableViewCell()
            }
            
            //當點擊此cell時，更新cell內容
            contentCell.didClickUnfoldButton = {
                tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
            
            if let toldescribe = attractionsInfo?.toldescribe {
                contentCell.convertCell(toldescribeText: toldescribe)
            } else {
                print("\(ShowInfoViewController.self) get toldescribe fail")
            }
            
            return contentCell
            
        case .phoneNumber:
            guard let phonenumberCell = tableView.dequeueReusableCell(withIdentifier: "\(PhoneCell.self)") as? PhoneCell else {
                print("get PhonenmberCell fail")
                return UITableViewCell()
            }
            
            if let phonenumber = attractionsInfo?.tel {
                phonenumberCell.convertCell(phoneNumber: phonenumber)
            } else {
                phonenumberCell.convertCell(phoneNumber: "此景點未提供電話")
            }
            
            return phonenumberCell
        }
        
    }
}
