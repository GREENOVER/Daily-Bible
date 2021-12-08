//
//  BibleRepository.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SQLite3

public protocol BibleRepository {
    func getAllBibles() -> [Bible]
    func getBibles(type: BibleType) -> [Bible]
}

public final class BibleRepositoryImpl: BibleRepository {
    public init() {}
    
    @UserDefault(key: "vcode", defaultValue: "")
    private var vcode: String
    
    public func getAllBibles() -> [Bible] {
        let queryString = "SELECT * FROM bibles where vcode = '\(vcode)'"
        
        return self.getBiblesFromDB(queryString)
    }
    
    public func getBibles(type: BibleType) -> [Bible] {
        let queryString = "SELECT * FROM bibles where vcode = '\(vcode)' AND type = '\(type.rawValue)'"
        
        return self.getBiblesFromDB(queryString)
    }
    
    private func getBiblesFromDB(_ queryString: String) -> [Bible] {
        var bibleList = [Bible]()
        
        var db: OpaquePointer?
        
        #if os(macOS)

        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("holybible.db")

        #else
        
        let fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.jeonggo.sqlite")!.appendingPathComponent("holybible.db")
        
        #endif
        
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
            let vcode = String(cString: sqlite3_column_text(stmt, 1))
            let bcode = sqlite3_column_int(stmt, 2)
            let type = String(cString: sqlite3_column_text(stmt, 3))
            let name = String(cString: sqlite3_column_text(stmt, 4))
            let chapterCount = sqlite3_column_int(stmt, 5)
            
            bibleList.append(Bible(id: Int(id), vcode: String(describing: vcode), bcode: Int(bcode), type: String(describing: type), name: String(describing: name), chapterCount: Int(chapterCount)))
        }
        
        return bibleList
    }
}
