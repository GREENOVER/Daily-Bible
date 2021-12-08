//
//  GyodokRepository.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SQLite3

public protocol GyodokRepository {
    static var gyodokData: [Gyodok] { get }
    static func getGyodoks() -> [Gyodok]
    func getDetailGyodoks(jang: Int) -> [Gyodok]
    func searchGyodoks(text: String) -> [Gyodok]
    static func getGyodoksFromDB(_ queryString: String) -> [Gyodok]
}

public final class GyodokRepositoryImpl: GyodokRepository {
    public static let gyodokData: [Gyodok] = getGyodoks()
    
    public init() {}
    
    public static func getGyodoks() -> [Gyodok] {
        let queryString = "SELECT * FROM gyodok where sojul = 1"
        
        return getGyodoksFromDB(queryString)
    }
    
    public func searchGyodoks(text: String) -> [Gyodok] {
        let queryString = "SELECT * FROM gyodok where title LIKE '%\(text)%' AND sojul = 1"
        
        return GyodokRepositoryImpl.getGyodoksFromDB(queryString)
    }
    
    public func getDetailGyodoks(jang: Int) -> [Gyodok] {
        let queryString = "SELECT * FROM gyodok where jang = \(jang)"
        
        return GyodokRepositoryImpl.getGyodoksFromDB(queryString)
    }
    
    public static func getGyodoksFromDB(_ queryString: String) -> [Gyodok] {
        var gyodokList = [Gyodok]()
        
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
            let jang = sqlite3_column_int(stmt, 1)
            let title = String(cString: sqlite3_column_text(stmt, 2))
            let sojul = sqlite3_column_int(stmt, 3)
            let note = String(cString: sqlite3_column_text(stmt, 4))
            
            gyodokList.append(Gyodok(id: Int(id), jang: Int(jang), title: String(describing: title), sojul: Int(sojul), note: String(describing: note)))
        }
        
        return gyodokList
    }
}
