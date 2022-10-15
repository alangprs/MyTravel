//
//  TouristAreaVM.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/10/15.
//

import Foundation
import Combine

class TouristAreaVM {
    
    // MARK: - 私有參數
    
    /// 各地區景點
    private lazy var areaData: [Info] = {
        return tripDataManager.getSelectTripData()
    }()
    
    ///過濾後資料
    var searchData = [Info]()
    ///過濾後的地區
    var towns = Set<String>()
    //存入剔除重複後的地區
    var townArray = [String]()
    
    private lazy var tripDataManager = TripDataManager.shard
    
    
    // MARK: - 外部呼叫
    
    public func getSelectData() -> [Info] {
        return areaData
    }
    
    
    // MARK: - 私有mathod
    
    ///將取得的地區過濾重複的 存進towns
    private func getTownData() {
        var noFilterTowns = [String]()
        for areaData in areaData {
            //解包、判斷town 有無值
            if let town = areaData.town, town.isEmpty == false {
                noFilterTowns.append(town)
            }
        }
        //將array內重複的剔除
        towns = Set(noFilterTowns)
        
        for towns in towns {
            townArray.append(towns)
        }
    }
    
}

// MARK: -

    



