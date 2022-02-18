//
//  TouristAreaViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/2/13.
// 各地區景點展示

enum ImageNameString: String {
    case backIcon
    case isSelectIcon, isNotSelectIcon
    case searchBtnIcon
}

extension ImageNameString {
    var titlerString: String {
        switch self {
        case .isSelectIcon:
            return "SearchBtnSelect"
        case .isNotSelectIcon:
            return "SearchBtnNormal"
        case .backIcon:
            return "backArrowBlack"
        case .searchBtnIcon:
            return "SearchBtnNormal"
        }
    }
}

import UIKit

class TouristAreaViewController: UIViewController {

    @IBOutlet weak var topView: TopBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var number: NSLayoutConstraint!
    
    var areaData = [Info]()
    var searchIsSelect: Bool = false {
        didSet {
            topViewRightButtonImageChang(isSelcet: searchIsSelect)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func uiSetup() {
        tableViewSetup()
        topView.setTitle(title: "景點列表")
        
        //返回按鈕
        topView.leftButtonSetup(imageName: ImageNameString.backIcon.titlerString) {
            self.navigationController?.popViewController(animated: true)
        }
        
        //搜尋按鈕
        topView.rightButtonSetup(imageName: ImageNameString.searchBtnIcon.titlerString) {
            self.searchIsSelect.toggle()
        }
    }

    ///topView 搜尋按鈕點選變色
    func topViewRightButtonImageChang(isSelcet: Bool) {
        topView.rightButton.isSelected = isSelcet
        
        
        switch isSelcet {
        case true:
            topView.rightButton.setImage(UIImage(named: ImageNameString.isSelectIcon.titlerString), for: .normal)
            //設定展開的view 大小
            self.number.constant = CGFloat(100)
        case false:
            topView.rightButton.setImage(UIImage(named: ImageNameString.isNotSelectIcon.titlerString), for: .normal)
            //將展開的view高度變０
            self.number.constant = CGFloat(0)
        }
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
