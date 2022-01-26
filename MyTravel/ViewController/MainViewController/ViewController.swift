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
    
    let layout = UICollectionViewFlowLayout()
    var tripData: [Info] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
        getNetworkData()
    }
    
    func uiSetup() {
        topBarView.setTitle(title: "首頁")
        collectionViewSetup()
    }

    ///打api 拿觀光局資料
    func getNetworkData() {
        if let url = URL(string: kAttractions) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                        
                        guard let searchResponse = searchResponse.xmlHead.infos.info else {
                            print("ViewController getNetworkData searchResponse get error")
                            return
                        }
                        self.tripData = searchResponse
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    } catch {
                        print("ViewController getNetworkData get data catch", error)
                    }
                } else {
                    print("ViewController getNetworkData get data error")
                }
            }.resume()
        }
    }
}

//MARK: -  擴充CollectionView

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //載入xib
        let nib = UINib(nibName: "\(ViewControllerCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(ViewControllerCell.self)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RegionSelect.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取得cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ViewControllerCell.self)", for: indexPath) as? ViewControllerCell else {
            print("ViewController collectionView get cell fail")
            return UICollectionViewCell()
        }
        
        //取得定義title內容
        guard let functions = RegionSelect(rawValue: indexPath.item) else {
            print("ViewController collectionView get functions fail")
            return UICollectionViewCell()
        }
        
        cell.convertCell(data: functions)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //設定item尺寸
        
        layout.itemSize = CGSize(width: view.frame.width / 3, height: 100)
        return layout.itemSize
    }
}

