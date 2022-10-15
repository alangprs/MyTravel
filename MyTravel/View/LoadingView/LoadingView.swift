//
//  LoadingView.swift
//  MyTravel
//
//  Created by will on 2022/2/11.
//

import UIKit

class LoadingView: UIView {

    private var lockView: UIView!
    private var activityIndicatorView: UIActivityIndicatorView!
    private var isLock: Bool = false
    
    /// loadingView 開始方法
    public func startAnimating()  {
        guard let superView = superview, lockView == nil else {
          print("Present error")
          return
        }
        
        let lockView = UIView()
        lockView.frame = superView.frame
        lockView.backgroundColor = UIColor.gray
        lockView.alpha = 0.9
        self.lockView = lockView

        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        activityIndicatorView.alpha = 1
        activityIndicatorView.center = CGPoint(x: superView.center.x, y: superView.center.y - 90)
        activityIndicatorView.startAnimating()
        self.activityIndicatorView = activityIndicatorView

        addSubview(lockView)
        addSubview(activityIndicatorView)
        
        isLock = true
    }
    
    ///loadingView 停止方法
    public func stopAnimating()  {
        
        DispatchQueue.main.async {
            if self.isLock {
                self.lockView.removeFromSuperview()
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.removeFromSuperview()
                self.lockView = nil
                self.activityIndicatorView = nil

                self.isLock = false
            } else {
                print("No Start Animating")
            }
        }
        
    }

}
