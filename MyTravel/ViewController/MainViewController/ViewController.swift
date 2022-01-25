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

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //載入xib
        let nib = UINib(nibName: "\(ViewControllerCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(ViewControllerCell.self)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ViewControllerCell.self)", for: indexPath) as? ViewControllerCell else {
            print("ViewController collectionView get ViewControllerCell fail")
            return UICollectionViewCell()
        }
        
        cell.convertCell(data: tripData[indexPath.item])
        
        return cell
    }
    
    
}

