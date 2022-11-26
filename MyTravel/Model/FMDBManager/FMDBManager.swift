//
//  FMDBManager.swift
//  MyTravel
//
//  Created by 翁燮羽 on 2022/11/23.
//

import Foundation
import FMDB

/*
 表格參數名稱對照表位置: notion
 https://illustrious-approval-f1f.notion.site/DB-Table-52cc2718e09f4955a95d77fa2193406d
 */

class FMDBManager: NSObject {
    static let shart = FMDBManager()
    
    /// 地區表格
    private let regionTable = "region_table"
    /// 景點總表格
    private let attractionsTable = "attractions_table"
    
    private let dbName = "travel_data.sqlite"
    
    private lazy var path: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/" + dbName
    
    private lazy var fildManager = FileManager.default
    
    private lazy var database: FMDatabase = {
        var database = FMDatabase(path: path)
        return database
    }()
    
    private override init() {
        super.init()
        
        createRegionTable()
        
        Logger.log(message: "Database Path: \(path)")
    }
    
    /// 創建 縣市 table
    private func createRegionTable() {
        
        if !fildManager.fileExists(atPath: path) {
            createTable()
            Logger.log(message: "is not have databast so create the table")
        } else {
            createTable()
            Logger.log(message: "have databast")
        }
    }
    
    private func createTable() {
        // 開啟 db
        if database.open() {
            Logger.log(message: "database is open")
            
            // 創建 縣市表格
            let regionTableSQL = getCreateRegionTableScript()
            database.executeStatements(regionTableSQL)
            
            // 創建 旅遊資訊總表格
            let attractionsTableSQL = getCreateAttractionsTableScript()
            database.executeStatements(attractionsTableSQL)
        }
    }
    
    // MARK: - 創建 table 參數
    
    private func getCreateRegionTableScript() -> String {
        
        let script = """
                            CREATE TABLE IF NOT EXISTS \(regionTable) (_id INTEGER primary key autoincrement, \(RegionTable.region) TEXT);
 """
        
        return script
    }
    
    private func getCreateAttractionsTableScript() -> String {
        let script = """
                            CREATE TABLE IF NOT EXISTS \(attractionsTable)
    (_id INTEGER primary key autoincrement,
    \(AttractionsTableNames.regionID) INTEGER,
    \(AttractionsTableNames.name) TEXT,
    \(AttractionsTableNames.description) TEXT,
    \(AttractionsTableNames.description_detail) TEXT,
    \(AttractionsTableNames.phone_number) INTEGER,
    \(AttractionsTableNames.address) TEXT,
    \(AttractionsTableNames.region_name) TEXT,
    \(AttractionsTableNames.town) TEXT,
    \(AttractionsTableNames.open_time) TEXT,
    \(AttractionsTableNames.picture1) TEXT,
    \(AttractionsTableNames.picture2) TEXT,
    \(AttractionsTableNames.picture3) TEXT,
    \(AttractionsTableNames.map) TEXT,
    \(AttractionsTableNames.class1) INTEGER,
    \(AttractionsTableNames.class2) INTEGER,
    \(AttractionsTableNames.class3) INTEGER,
    \(AttractionsTableNames.level) INTEGER,
    \(AttractionsTableNames.web) TEXT,
    \(AttractionsTableNames.parking_info) TEXT,
    \(AttractionsTableNames.ticket_info) TEXT
);
"""
        return script
    }
}
