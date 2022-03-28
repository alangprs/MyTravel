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
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    ///過濾後的地區
    var towns = Set<String>()
    //存入剔除重複後的地區
    var townArray = [String]()
    ///是否為搜尋狀態
    var isSearch: Bool = false
    ///是否為tag狀態
    var isSelectTag: Bool = true
    ///item大小
    var layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getTownData()
    }
    
    //MARK: - UI
    
    private func uiSetup() {
        tableViewSetup()
        collectionViewSetUp()
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
    
    //MARK: - Method
    
    ///將取得的地區過濾重複的 存進towns
    private func getTownData() {
        var noFilterTowns = [String]()
        for areaData in areaData {
            //解包、判斷town 有無值
            if let town = areaData.town, town.isEmpty == false {
                noFilterTowns.append(town)
            }
        }
        //將array內重複的剔除
        towns = Set(noFilterTowns)
        
        for towns in towns {
            townArray.append(towns)
        }
    }
}

//MARK: - UITableViewDelegate

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

//MARK: - CollectionViewDelegate

extension TouristAreaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionViewSetUp() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //開啟分頁
        collectionView.isPagingEnabled = true
        //設定滾動方向
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        //加入xib
        let nib = UINib(nibName: "\(TagCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(TagCell.self)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return towns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TagCell.self)", for: indexPath) as? TagCell else {
            print("\(TouristAreaViewController.self) get collectionView cell fail")
            return UICollectionViewCell()
        }
        
        cell.convertCell(data: townArray[indexPath.item])
        
        return cell
    }
    
    //設定tag item大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize = CGSize()
        //設定文字大小
        let textFont = UIFont.systemFont(ofSize: 17)
        //取得每個文字
        let tetxString = townArray[indexPath.item]

        let textMaxSize = CGSize(width: 240, height: CGFloat(MAXFLOAT))
        let textLabelSize = self.textSize(text:tetxString , font: textFont, maxSize: textMaxSize)
        
        //cell 高度、寬度
        cellSize.width = textLabelSize.width + 40
        cellSize.height = 30
        return cellSize
    }
    
    func textSize(text : String , font : UIFont , maxSize : CGSize) -> CGSize{
        return text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
    
    //選到後動作
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var tagdata = [Info]()
        isSelectTag.toggle()
        
        if isSelectTag {
            print("測試 被點true狀態 ", isSelectTag)
            //選到的地區
            let selectTown = townArray[indexPath.item]
            tagdata = areaData.filter { (data) in
                guard data.town == selectTown else {
                    return false
                }
                
                return true
            }
        } else {
            print("測試 被點fals狀態", isSelectTag)
        }
        
        
        tableView.reloadData()
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
