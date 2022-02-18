//
//  TouristAreaViewController.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/2/13.
// 各地區景點展示

import UIKit

class TouristAreaViewController: UIViewController {

    @IBOutlet weak var topView: TopBarView!
    @IBOutlet weak var tableView: UITableView!
    
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
        topView.leftButtonSetup(imageName: "backArrowBlack") {
            self.navigationController?.popViewController(animated: true)
        }
        
        //搜尋按鈕
        topView.rightButtonSetup(imageName: "SearchBtnNormal") {
            //預計放一個可以伸縮的view，放搜尋的bar
            self.searchIsSelect.toggle()
        }
    }

    ///topView 搜尋按鈕點選變色
    func topViewRightButtonImageChang(isSelcet: Bool) {
        topView.rightButton.isSelected = isSelcet
        
        switch isSelcet {
        case true:
            topView.rightButton.setImage(UIImage(named: "SearchBtnSelect"), for: .normal)
        case false:
            topView.rightButton.setImage(UIImage(named: "SearchBtnNormal"), for: .normal)
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
