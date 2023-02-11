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
    
    /// 搜尋按鈕開關變色
    var searchIsSelect: Bool = false {
        didSet {
            topViewRightButtonImageChang(isSelcet: searchIsSelect)
        }
    }
    
    ///是否為搜尋狀態
    private lazy var isSearch: Bool = {
       return false
    }()
    
    /// 是否為tag狀態
    private lazy var isSelectTag: Bool = {
       return false
    }()
    
    /// item大小
    private lazy var layout: UICollectionViewFlowLayout = {
        return UICollectionViewFlowLayout()
    }()
    
    private lazy var viewModel: TouristAreaVM = {
        var vm = TouristAreaVM()
        return vm
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTownData()
    }
    
    // MARK: - set
    
    private func setupUI() {
        setupTableView()
        setupCollectionView()
        setSearchBarDelegate()
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
    
    /// topView 搜尋按鈕點選變色
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
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "\(TouristAreaCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(TouristAreaCell.self)")
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 開啟分頁
        collectionView.isPagingEnabled = true
        // 設定滾動方向
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        // 加入xib
        let nib = UINib(nibName: "\(TagCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(TagCell.self)")
        
    }
    
    private func setSearchBarDelegate() {
        searchBar.delegate = self
    }
    
}

// MARK: - UITableViewDelegate

extension TouristAreaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch || isSelectTag {
            return viewModel.searchDataCount
        } else {
            return viewModel.areaDataCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TouristAreaCell.self)", for: indexPath) as? TouristAreaCell else {
            Logger.log(message: "Get TouristAreaCell Fail")
            return UITableViewCell()
        }
        
        if isSearch || isSelectTag {
            cell.convertCell(data: viewModel.getSearchData(indexpath: indexPath))
        } else {
            cell.convertCell(data: viewModel.getSelectData(indexpath: indexPath))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = ShowInfoViewController()
        
        // 判斷顯示過濾後資料還是未過濾資料
        if isSearch || isSelectTag {
            let searchData = viewModel.getSearchData(indexpath: indexPath)
            viewModel.getAttractionsInfo(attraction: searchData)
        } else {
            let selectData = viewModel.getSelectData(indexpath: indexPath)
            viewModel.getAttractionsInfo(attraction: selectData)
        }
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - CollectionViewDelegate

extension TouristAreaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.townArrayCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(TagCell.self)", for: indexPath) as? TagCell else {
            Logger.log(message: "get collectionView cell fail")
            return UICollectionViewCell()
        }
        
        cell.convertCell(data: viewModel.getTownArray(indexpath: indexPath))
        
        return cell
    }
    
    //設定tag item大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize = CGSize()
        // 設定文字大小
        let textFont = UIFont.systemFont(ofSize: 17)
        // 取得每個文字
        let tetxString = viewModel.getTownArray(indexpath: indexPath)
        
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

        guard let cell = collectionView.cellForItem(at: indexPath) else {
            Logger.log(message: "gat cellForItem fail")
            return
        }

        isSelectTag.toggle()

        if isSelectTag {
            cell.contentView.backgroundColor = .red
            // 選到的地區
            viewModel.filterToSelectTag(indexPath: indexPath)
            
        } else {
            cell.contentView.backgroundColor = .clear
        }

        tableView.reloadData()
    }
    
}

//MARK: - SearchBar 設定
extension TouristAreaViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearch = true
        viewModel.searchData(searchText: searchText)
        tableView.reloadData()
        
    }
    
    // 按下搜尋bar鍵盤的搜尋時，關閉鍵盤
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.resignFirstResponder()
    }
}
