//
//  ViewController.swift
//  MyTravel
//
//  Created by will on 2022/1/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topBarView: TopBarView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - parameter
    
    private lazy var loadingView: LoadingView = {
        return LoadingView()
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
       return UICollectionViewFlowLayout()
    }()
    
    private lazy var viewModel: ViewControllerVM = {
        var vm = ViewControllerVM()
        return vm
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getNetworkData()
    }

    // MARK: - set
    
    private func setupUI() {
        loadViewSetup()
        topBarView.setTitle(title: "首頁")
        collectionViewSetup()
    }
    
    private func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "\(ViewControllerCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(ViewControllerCell.self)")
        
    }
    
    /// loadView 設定
    private func loadViewSetup() {
        let loadView = LoadingView()
        view.addSubview(loadView)
        self.loadingView = loadView
    }
    
    // MARK: - get
    
    private func getNetworkData() {
        
        loadingView.startAnimating()
        
        viewModel.getNetworkData { result in
            
            switch result {
            case .success():
                // 成功後動作
                print("success")
            case .failure(_):
                // 失敗後動作
                print("error")
            }
            
            self.loadingView.stopAnimating()
        }
    }
}

//MARK: -  擴充CollectionView

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RegionSelect.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取得cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ViewControllerCell.self)", for: indexPath) as? ViewControllerCell else {
            Logger.log(message: "get cell fail")
            return UICollectionViewCell()
        }
        
        //取得定義title內容
        guard let functions = RegionSelect(rawValue: indexPath.item) else {
            Logger.log(message: "get functions fail")
            return UICollectionViewCell()
        }
        
        cell.convertCell(data: functions, imageName: functions.titleString)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //設定item尺寸
        layout.itemSize = CGSize(width: view.frame.width - 30, height: 180)
        return layout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = RegionSelect(rawValue: indexPath.item) else {
            Logger.log(message: "get RegionSelect error")
            return
        }
        
        viewModel.selectTripData(areaItem: item)
        let vc = TouristAreaViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

