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
        
        photoImageView.image = nil
        keepSession?.cancel()
    }
    
    func convertCell(data: Any) {
        
        guard let info = data as? Info else {
            print("TouristAreaCell Get info fial")
            return
        }
        
        getNetworkImageData(imageData: info)
        titleLabel.text = info.name
    }
    
    //打api取得圖片
    private func getNetworkImageData(imageData: Info) {
        
        guard let imageString = imageData.picture1,
              let url = URL(string: imageString) else {
                  print("TouristAreaCell getNetworkImageData Get Fail")
                  self.photoImageView.image = UIImage(systemName: "photo.artframe")
                  return
              }
        //將http轉成https
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        guard let urlComponent = urlComponents?.url else { return }
        
         let session = URLSession.shared.dataTask(with: urlComponent) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data)
                }
            }
        }
        session.resume()
        keepSession = session
    }
    
}
