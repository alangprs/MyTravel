//
//  TouristAreaVM.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/10/15.
//

import Foundation

class TouristAreaVM {
    
    // MARK: - 私有參數
    
    /// 各地區景點
    private lazy var areaData: [Info] = {
        return tripDataManager.getSelectTripData()
    }()
    
    /// 搜尋後資料
    private lazy var searchData: [Info] = {
        return [Info]()
    }()
    
    /// 過濾後的地區
    private lazy var towns: Set<String> = {
        return Set<String>()
    }()
    
    /// 存入剔除重複後的地區
    private lazy var townArray: [String] = {
        return [String]()
    }()
    
    private lazy var tripDataManager = TripDataManager.shard
    
    
    // MARK: - 開放參數
    
    /// 各地區景點數量
    public lazy var areaDataCount: Int = {
        var areaDataCount = Int()
        areaDataCount = areaData.count
        return areaDataCount
    }()
    
    /// 搜尋後資料數量
    public lazy var searchDataCount: Int = {
        var searchDataCount = Int()
        searchDataCount = searchData.count
        return searchDataCount
    }()
    
    /// 存入剔除重複後的地區數量
    public lazy var townArrayCount: Int = {
        var townArrayCount = Int()
        townArrayCount = townArray.count
        return townArrayCount
    }()
    
    // MARK: - 外部呼叫
    
    public func getSelectData(indexpath: IndexPath) -> Info {
        return areaData[indexpath.row]
    }
    
    /// 取得搜尋後資料
    public func getSearchData(indexpath: IndexPath) -> Info {
        return searchData[indexpath.row]
    }
    
    /// 取得剔除重複後的地區
    public func getTownArray(indexpath: IndexPath) -> String {
        return townArray[indexpath.row]
    }
    
    /// 取得景點資料
    public func getAttractionsInfo(attraction: Info) {
        return tripDataManager.getAttractionsInfo(attraction: attraction)
    }
    
    /// 搜尋
    /// - Parameter searchText: 搜尋內容
    public func searchData(searchText: String) {
        
        // 高階函數：判斷data資料裡面有無searchText輸入的內容
        searchData = areaData.filter { (search) in
            guard let searchData = search.name else {
                print("filter fial")
                return false
            }
            return searchData.hasPrefix(searchText)
        }
    }
    
    /// 將取得的地區過濾重複的 存進towns
    public func getTownData() {
        var noFilterTowns = [String]()
        for areaData in areaData {
            //解包、判斷town 有無值
            if let town = areaData.town, town.isEmpty == false {
                noFilterTowns.append(town)
            }
        }
        // 將array內重複的剔除
        towns = Set(noFilterTowns)
        
        for towns in towns {
            townArray.append(towns)
        }
    }
    
    /// 過濾出tag到的資料
    public func filterToSelectTag(indexPath: IndexPath) {
        
        let selectTown = townArray[indexPath.row]
        searchData = areaData.filter { (data) in
            guard data.town == selectTown else {
                return false
            }
            
            return true
        }
    }
    
}





