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
    let listname, language: String
    let updatetime: Date
    let infos: Infos

    enum CodingKeys: String, CodingKey {
        case listname = "Listname"
        case language = "Language"
        case updatetime = "Updatetime"
        case infos = "Infos"
    }
}

// MARK: - Infos
struct Infos: Codable {
    let info: [Info]

    enum CodingKeys: String, CodingKey {
        case info = "Info"
    }
}

// MARK: - Info
struct Info: Codable {
    let id, name: String
    let toldescribe: String
    let infoDescription: String?
    let tel: String
    let add: String?
    let region: Region?
    let town: String?
    let opentime: String
    let picture1: String?
    let picdescribe1: String?
    let picture2: String?
    let picdescribe2: String?
    let picture3: String?
    let picdescribe3: String?
    let map: String?
    let px, py: Double
    let orgclass: Orgclass?
    let class1: String
    let class2, class3, level: String?
    let website: String?
    let ticketinfo: String?
    let changetime: Date?

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
        case orgclass = "Orgclass"
        case class1 = "Class1"
        case class2 = "Class2"
        case class3 = "Class3"
        case level = "Level"
        case website = "Website"
        case ticketinfo = "Ticketinfo"
        case changetime = "Changetime"
    }
}


enum Orgclass: String, Codable {
    case empty = ""
    case 休閒景點 = "休閒景點"
    case 休閒景點文化景點 = "休閒景點、文化景點"
    case 休閒景點特色展館 = "休閒景點、特色展館"
    case 公園遊憩 = "公園遊憩"
    case 單車漫遊 = "單車漫遊"
    case 寺廟參訪 = "寺廟參訪"
    case 展覽博物 = "展覽博物"
    case 工藝創作 = "工藝創作"
    case 廟宇古蹟 = "廟宇古蹟"
    case 文化景點 = "文化景點"
    case 文化類 = "文化類"
    case 桃米生態村 = "桃米生態村"
    case 海岸風情 = "海岸風情"
    case 濱海風光 = "濱海風光"
    case 特色展館 = "特色展館"
    case 特色展館文化景點 = "特色展館、文化景點"
    case 特色展館觀光工廠 = "特色展館、觀光工廠"
    case 生態景觀 = "生態景觀"
    case 生態景觀休閒景點自行車道 = "生態景觀、休閒景點、自行車道"
    case 綠野森呼吸 = "綠野森呼吸"
    case 縱情花田 = "縱情花田"
    case 老街巡禮 = "老街巡禮"
    case 親子同遊 = "親子同遊"
    case 觀光工廠 = "觀光工廠"
    case 鐵道懷舊 = "鐵道懷舊"
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
