//
//  NetworkStruct-Attractions.swift
//  MyTravel
//
//  Created by will on 2022/1/25.
// jean資料

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let xmlHead: XMLHead

    enum CodingKeys: String, CodingKey {
        case xmlHead = "XML_Head"
    }
}

// MARK: - XMLHead
struct XMLHead: Codable {
    let listname, language: String?
    let infos: Infos

    enum CodingKeys: String, CodingKey {
        case listname = "Listname"
        case language = "Language"
        case infos = "Infos"
    }
}

// MARK: - Infos
struct Infos: Codable {
    let info: [Info]?

    enum CodingKeys: String, CodingKey {
        case info = "Info"
    }
}

// MARK: - Info
struct Info: Codable {
    let id, name: String?
    let toldescribe: String?
    let infoDescription: String?
    let tel: String?
    let add: String?
    let region: Region?
    let town: String?
    let opentime: String?
    let picture1: String?
    let picdescribe1: String?
    let picture2: String?
    let picdescribe2: String?
    let picture3: String?
    let picdescribe3: String?
    let map: String?
    let px, py: Float?
    let class1: String?
    let class2, class3, level: String?
    let website: String?
    let ticketinfo: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case toldescribe = "Toldescribe"
        case infoDescription = "Description"
        case tel = "Tel"
        case add = "Add"
        case region = "Region"
        case town = "Town"
        case opentime = "Opentime"
        case picture1 = "Picture1"
        case picdescribe1 = "Picdescribe1"
        case picture2 = "Picture2"
        case picdescribe2 = "Picdescribe2"
        case picture3 = "Picture3"
        case picdescribe3 = "Picdescribe3"
        case map = "Map"
        case px = "Px"
        case py = "Py"
        case class1 = "Class1"
        case class2 = "Class2"
        case class3 = "Class3"
        case level = "Level"
        case website = "Website"
        case ticketinfo = "Ticketinfo"
    }
}


enum Region: String, Codable {
    case 南投縣 = "南投縣"
    case 嘉義市 = "嘉義市"
    case 嘉義縣 = "嘉義縣"
    case 基隆市 = "基隆市"
    case 宜蘭縣 = "宜蘭縣"
    case 屏東縣 = "屏東縣"
    case 彰化縣 = "彰化縣"
    case 新北市 = "新北市"
    case 新竹市 = "新竹市"
    case 新竹縣 = "新竹縣"
    case 桃園市 = "桃園市"
    case 澎湖縣 = "澎湖縣"
    case 臺中市 = "臺中市"
    case 臺北市 = "臺北市"
    case 臺南市 = "臺南市"
    case 臺東縣 = "臺東縣"
    case 花蓮縣 = "花蓮縣"
    case 苗栗縣 = "苗栗縣"
    case 連江縣 = "連江縣"
    case 金門縣 = "金門縣"
    case 雲林縣 = "雲林縣"
    case 高雄市 = "高雄市"
}
