//
//  ShowInfoVM.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/10/16.
//

import Foundation
import Combine

class ShowInfoVM {
    
    deinit {
        print("ShowInfoVM deinit")
    }
    
    private lazy var tripDataManager = TripDataManager.shard
    
    /// 景點資料
    private var attractionsInfo: [Info] = {
       return [Info]()
    }()
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        binAttractionsInfoData()
    }
    
    // MARK: - 外部呼叫
    
    /// 取得景點資料
    public func getAttractionsInfo(indexPath: IndexPath) -> Info? {
        
        guard attractionsInfo.indices.contains(indexPath.row) else {
            return nil
        }
        
        return attractionsInfo[indexPath.row]
    }
    
    // MARK: - 私有mothed
    
    private func binAttractionsInfoData() {
        
        tripDataManager.attractionsInfoPubalesher
            .sink { info in
                self.attractionsInfo = [info]
            }
            .store(in: &cancellable)
    }
}
