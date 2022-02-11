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
    
    //MRAK: - 各縣市資料暫存
    var tripData: [Info] = []
    var taipaiArea: [Info] = []
    var newTaipei: [Info] = []
    var keelung: [Info] = []
    var taoyuan: [Info] = []
    var hsinchu: [Info] = []
    var miaoli: [Info] = []
    var taichung: [Info] = []
    var changhua: [Info] = []
    var nantou: [Info] = []
    var yunlin: [Info] = []
    var chiayi: [Info] = []
    var tainan: [Info] = []
    var kaohsiung: [Info] = []
    var pingtung: [Info] = []
    var yilan: [Info] = []
    var hualien: [Info] = []
    var tautung: [Info] = []
    var penghu: [Info] = []
    var kinmen: [Info] = []
    var lienchiang: [Info] = []
    
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
                        self.filterArea()
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
    
    ///過濾選擇到的地區
    func filterArea() {
        //判斷是否取得資料了
        if tripData.count != 0 {
            taipaiArea = tripData.filter({$0.region == Region.臺北市})
            newTaipei = tripData.filter({$0.region == Region.新北市})
            keelung = tripData.filter({$0.region == Region.基隆市})
            taoyuan = tripData.filter({$0.region == Region.桃園市})
            hsinchu = tripData.filter({$0.region == Region.新竹縣 || $0.region == Region.新竹市})
            miaoli = tripData.filter({$0.region == Region.苗栗縣})
            taichung = tripData.filter({$0.region == Region.臺中市})
            changhua = tripData.filter({$0.region == Region.彰化縣})
            nantou = tripData.filter({$0.region == Region.南投縣})
            yunlin = tripData.filter({$0.region == Region.雲林縣})
            chiayi = tripData.filter({$0.region == Region.嘉義市 || $0.region == Region.嘉義縣})
            tainan = tripData.filter({$0.region == Region.臺南市})
            kaohsiung = tripData.filter({$0.region == Region.高雄市})
            pingtung = tripData.filter({$0.region == Region.屏東縣})
            yilan = tripData.filter({$0.region == Region.宜蘭縣})
            hualien = tripData.filter({$0.region == Region.花蓮縣})
            tautung = tripData.filter({$0.region == Region.臺東縣})
            penghu = tripData.filter({$0.region == Region.澎湖縣})
            kinmen = tripData.filter({$0.region == Region.金門縣})
            lienchiang = tripData.filter({$0.region == Region.連江縣})
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
        layout.itemSize = CGSize(width: view.frame.width / 2.5, height: 100)
        return layout.itemSize
    }
}

