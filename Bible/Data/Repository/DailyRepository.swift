//
//  DailyRepository.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SQLite3

public protocol DailyRepository {
    static var dailyData: [Daily] { get }
    static func getDailys() -> [Daily]
}

public final class DailyRepositoryImpl: DailyRepository {
    public static let dailyData = getDailys()
    
    public init() {}
    
    public static func getDailys() -> [Daily] {
        let queryString = "SELECT * FROM todaybible"
        
        var dailyList = [Daily]()
        
        var db: OpaquePointer?
        
        let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.jeonggo.sqlite")!.appendingPathComponent("holybible.db")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let bible = String(cString: sqlite3_column_text(stmt, 1))
            let content = String(cString: sqlite3_column_text(stmt, 2))
            
            dailyList.append(Daily(id: Int(id), bible: String(describing: bible), content: String(describing: content)))
        }
        
        return dailyList
    }
}
