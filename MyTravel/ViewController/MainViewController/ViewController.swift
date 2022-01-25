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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetup()
    }
    
    func uiSetup() {
        topBarView.setTitle(title: "首頁")
        collectionViewSetup()
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionViewSetup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //載入xib
        let nib = UINib(nibName: "\(ViewControllerCell.self)", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "\(ViewControllerCell.self)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ViewControllerCell.self)", for: indexPath) as? ViewControllerCell else {
            print("ViewController collectionView get ViewControllerCell fail")
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

