//
//  TopBarView.swift
//  MyTravel
//
//  Created by will on 2022/1/24.
//

import UIKit

class TopBarView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    var didClickLeftButton: (()->Void)?
    var didClickRightButton: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadXib()
    }
    
    ///用於載入xib
    private func loadXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let xibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        backgroundColor = UIColor.clear
        addSubview(xibView)
        xibView.frame = self.frame
    }

    ///抬頭設定
    func setTitle(title: String, textColor: UIColor = .black, fontSize: CGFloat = 18, weight: UIFont.Weight = .medium) {
        titleLabel.text = title
        titleLabel.textColor = textColor
        titleLabel.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
    
    /// 左邊按鈕預設隱藏，呼叫此方法才會出現
    func leftButtonSetup(imageName: String = "backArrow", action: (()->Void)? = nil) {
        leftButton.isHidden = false
        leftButton.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        didClickLeftButton = action
    }
    
    /// 右邊按鈕預設隱藏，呼叫此方法才會出現
    func rightButtonSetup(imageName: String = "cancelpageIcon", action: (()->Void)? = nil) {
        rightButton.isHidden = false
        rightButton.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        didClickRightButton = action
    }
    
    @IBAction func leftButtonClick(_ sender: UIButton) {
        didClickLeftButton?()
    }
    
    @IBAction func rightButtonClick(_ sender: UIButton) {
        didClickRightButton?()
    }
}
