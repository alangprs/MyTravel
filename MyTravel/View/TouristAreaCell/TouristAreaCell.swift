//
//  TouristAreaCell.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/2/13.
//

import UIKit

class TouristAreaCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var keepSession: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        keepSession?.cancel()
    }
    
    func convertCell(data: Any) {
        
        guard let info = data as? Info else {
            print("TouristAreaCell Get info fial")
            return
        }
        
        getNetworkImageData(imageString: info.picture1 ?? "")
        titleLabel.text = info.name
    }
    
    //打api取得圖片
    private func getNetworkImageData(imageString: String) {
        if let url = URL(string: imageString) {
            let session = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        
                        self.photoImageView.image = UIImage(data: data)
                    }
                }
            }
            // 執行抓照片任務
            session.resume()
            // 將抓照片任務交接給keepSession
            keepSession = session
        }
        
    }
    
}
