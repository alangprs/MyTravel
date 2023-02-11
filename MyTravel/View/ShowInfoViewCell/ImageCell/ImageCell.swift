//
//  ImageCell.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/3/8.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var showInfoImageView: UIImageView!
    
    func convertCell(data: String) {
        
        getNetworkImageData(imageUrl: data)
    }
    
    //打api取得圖片
    private func getNetworkImageData(imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else {
            Logger.log(message: "getNetworkImageData Get Fail")
            self.showInfoImageView.image = UIImage(named: "bear")
            return
        }
        //將http轉成https
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        guard let urlComponent = urlComponents?.url else { return }
        
        let session = URLSession.shared.dataTask(with: urlComponent) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.showInfoImageView.image = UIImage(data: data)
                }
            }
        }
        session.resume()
    }
    
}
