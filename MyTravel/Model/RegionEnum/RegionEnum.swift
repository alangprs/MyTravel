//
//  RegionEnum.swift
//  MyTravel
//
//  Created by will on 2022/1/26.
// 地點分類enum

import Foundation

enum RegionSelect: Int,CaseIterable {
    ///北北基桃苗
    case taipai = 0, newTaipei = 1, keelung = 2, taoyuan = 3, hsinchu = 4, miaoli = 5
    ///中、彰、投、雲、嘉、南、高、屏
    case taichung = 6, changhua = 7, nantou = 8, yunlin = 9, chiayi = 10, tainan = 11, kaohsiung = 12, pingtung = 13
    ///宜花東
    case yilan = 14, hualien = 15, tautung = 16
    /// 澎湖、金門、連江
    case penghu = 17, kinmen = 18, lienchiang = 19
    
}

extension RegionSelect {
    var titleString: String {
        switch self {
        case .taipai:
            return "台北"
        case .newTaipei:
            return "新北"
        case .keelung:
            return "基隆"
        case .taoyuan:
            return "桃園"
        case .hsinchu:
            return "新竹"
        case .miaoli:
            return "苗栗"
        case .taichung:
            return "台中"
        case .changhua:
            return "彰化"
        case .nantou:
            return "南投"
        case .yunlin:
            return "雲林"
        case .chiayi:
            return "嘉義"
        case .tainan:
            return "台南"
        case .kaohsiung:
            return "高雄"
        case .pingtung:
            return "屏東"
        case .yilan:
            return "宜蘭"
        case .hualien:
            return "花蓮"
        case .tautung:
            return "台東"
        case .penghu:
            return "澎湖"
        case .kinmen:
            return "金門"
        case .lienchiang:
            return "連江"
        }
    }
}

