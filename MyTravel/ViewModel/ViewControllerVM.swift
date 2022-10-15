//
//  ViewControllerVM.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/10/15.
//

import Foundation

class ViewControllerVM {
    
    /// 取得景點資料
    public func getNetworkData(completion: @escaping (Result<Void,Error>) -> Void) {
        TripDataManager.shard.getNetworkData { result in
            
            switch result {
                
            case .success():
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// 選取點到城市
    public func selectTripData(areaItem: RegionSelect) {
        TripDataManager.shard.areaItem = areaItem
    }
    
}
