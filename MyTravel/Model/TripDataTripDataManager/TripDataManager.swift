//
//  TripDataManager.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/10/15.
//

import Foundation
import Combine

class TripDataManager {
    
    static let shard = TripDataManager()
    
    var areaItem: RegionSelect?
    
    var attractionsInfoPubalesher = PassthroughSubject<Info,Never>()
    
    // MARK: - 各縣市資料暫存
    
    /// 所有資料集合
    var tripData: [Info] = []
    
    var taipaiArea: [Info] = []
    var newTaipei: [Info] = []
    var keelung: [Info] = []
    var taoyuan: [Info] = []
    var hsinchu: [Info] = []
    var miaoli: [Info] = []
    var taichung: [Info] = []
    var changhua: [Info] = []
    var nantou: [Info] = []
    var yunlin: [Info] = []
    var chiayi: [Info] = []
    var tainan: [Info] = []
    var kaohsiung: [Info] = []
    var pingtung: [Info] = []
    var yilan: [Info] = []
    var hualien: [Info] = []
    var tautung: [Info] = []
    var penghu: [Info] = []
    var kinmen: [Info] = []
    var lienchiang: [Info] = []
    
    
    // MARK: - 外部呼叫
    
    /// 打api 拿觀光局資料
    public func getNetworkData(completion: @escaping (Result<Void,Error>) -> Void) {
        if let url = URL(string: kAttractions) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                        
                        guard let searchResponse = searchResponse.xmlHead.infos.info else {
                            Logger.log(message: "searchResponse get fail")
                            return
                        }
                        self.tripData = searchResponse
                        self.filterArea()
                        completion(.success(Void()))
                        
                    } catch {
                        Logger.log(message: "get data catch: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    print("ViewController getNetworkData get data error: \(String(describing: error))")
                    Logger.log(message: "get data error: \(String(describing: error))")
                    
                }
            }.resume()
        }
    }
    
    /// 取得被點選到的資料
    public func getSelectTripData() -> [Info] {
        
        switch areaItem {
        case .taipai:
            return taipaiArea
        case .newTaipei:
            return newTaipei

        case .keelung:
            return keelung
        case .taoyuan:
            return hsinchu
        case .hsinchu:
            return miaoli
        case .miaoli:
            return taichung
        case .taichung:
            return changhua
        case .changhua:
            return nantou
        case .nantou:
            return yunlin
        case .yunlin:
            return chiayi
        case .chiayi:
            return tainan
        case .tainan:
            return kaohsiung
        case .kaohsiung:
            return pingtung
        case .pingtung:
            return yilan
        case .yilan:
            return hualien
        case .hualien:
            return tautung
        case .tautung:
            return penghu
        case .penghu:
            return kinmen
        case .kinmen:
            return lienchiang
        case .lienchiang:
            return lienchiang
            
        default:
            return tripData
        }
        
    }
    
    /// 取得景點資料
    public func getAttractionsInfo(attraction: Info) {
        
        attractionsInfoPubalesher
            .send(attraction)
    }
    
    
    // MARK: - 內部func
    
    ///過濾選擇到的地區
    private func filterArea() {
        //判斷是否取得資料了
        if tripData.count != 0 {
            taipaiArea = tripData.filter({$0.region == Region.臺北市})
            newTaipei = tripData.filter({$0.region == Region.新北市})
            keelung = tripData.filter({$0.region == Region.基隆市})
            taoyuan = tripData.filter({$0.region == Region.桃園市})
            hsinchu = tripData.filter({$0.region == Region.新竹縣 || $0.region == Region.新竹市})
            miaoli = tripData.filter({$0.region == Region.苗栗縣})
            taichung = tripData.filter({$0.region == Region.臺中市})
            changhua = tripData.filter({$0.region == Region.彰化縣})
            nantou = tripData.filter({$0.region == Region.南投縣})
            yunlin = tripData.filter({$0.region == Region.雲林縣})
            chiayi = tripData.filter({$0.region == Region.嘉義市 || $0.region == Region.嘉義縣})
            tainan = tripData.filter({$0.region == Region.臺南市})
            kaohsiung = tripData.filter({$0.region == Region.高雄市})
            pingtung = tripData.filter({$0.region == Region.屏東縣})
            yilan = tripData.filter({$0.region == Region.宜蘭縣})
            hualien = tripData.filter({$0.region == Region.花蓮縣})
            tautung = tripData.filter({$0.region == Region.臺東縣})
            penghu = tripData.filter({$0.region == Region.澎湖縣})
            kinmen = tripData.filter({$0.region == Region.金門縣})
            lienchiang = tripData.filter({$0.region == Region.連江縣})
        }
    }
}
