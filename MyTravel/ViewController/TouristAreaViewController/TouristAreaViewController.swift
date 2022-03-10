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
    @IBOutlet weak var searchBar: UISearchBar!
    
    ///顯示前一頁傳來各地區資料
    var areaData = [Info]()
    ///過濾後資料
    var searchData = [Info]()
    ///搜尋按鈕開關變色
    var searchIsSelect: Bool = false {
        didSet {
            topViewRightButtonImageChang(isSelcet: searchIsSelect)
        }
    }
    ///是否為搜尋狀態
    var isSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func uiSetup() {
        tableViewSetup()
        searchBarUisetup()
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
    private func topViewRightButtonImageChang(isSelcet: Bool) {
        topView.rightButton.isSelected = isSelcet
        
        
        switch isSelcet {
        case true:
            topView.rightButton.setImage(UIImage(named: ImageNameString.isSelectIcon.titlerString), for: .normal)
            //設定展開的view 大小
            self.number.constant = CGFloat(80)
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
        
        if isSearch {
            return searchData.count
        } else {
            return areaData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TouristAreaCell.self)", for: indexPath) as? TouristAreaCell else {
            print("TouristAreaViewController Get TouristAreaCell Fail")
            return UITableViewCell()
        }
        
        if isSearch {
            cell.convertCell(data: searchData[indexPath.row])
        } else {
            cell.convertCell(data: areaData[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = ShowInfoViewController()
        
        //判斷顯示過濾後資料還是未過濾資料
        if isSearch {
            controller.areaData = searchData[indexPath.row]
        } else {
            controller.areaData = areaData[indexPath.row]
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

//MARK: - SearchBar 設定
extension TouristAreaViewController: UISearchBarDelegate {
    
    func searchBarUisetup() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearch = true
 
        
        //高階函數：判斷data資料裡面有無searchText輸入的內容
        searchData = areaData.filter { (search) in
            guard let searchData = search.name else {
                print("filter fial")
                return false
            }
            return searchData.hasPrefix(searchText)
        }
        
        tableView.reloadData()
        
    }
    
    
    //按下搜尋bar鍵盤的搜尋時，關閉鍵盤
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.resignFirstResponder()
    }
}
