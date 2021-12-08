//
//  VerseRepository.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SQLite3

public protocol VerseRepository {
    func getVerses() -> [Verse]
    func getCurrentBible() -> Bible
    func getBookmarkedVerses() -> [Verse]
    func updateBookmark(isBookmark: Bool, id: Int)
    func getVersesFromDB(_ queryString: String) -> [Verse]
}

public final class VerseRepositoryImpl: VerseRepository {
    @UserDefault(key: "bcode", defaultValue: "")
    private var bcode: String
    
    @UserDefault(key: "vcode", defaultValue: "")
    private var vcode: String
    
    @UserDefault(key: "cnum", defaultValue: "")
    private var cnum: String
    
    public init() {}
    
    public func getVerses() -> [Verse] {
        let queryString = "SELECT * FROM verses where bcode = '\(bcode)' AND cnum = '\(cnum)' AND vcode = '\(vcode)'"
        
        return self.getVersesFromDB(queryString)
    }
    
    public func getBookmarkedVerses() -> [Verse] {
        let queryString = "SELECT * FROM verses where bookmarked = 1"
        
        return self.getVersesFromDB(queryString)
    }
    
    public func updateBookmark(isBookmark: Bool, id: Int) {
        let queryString = "UPDATE verses set bookmarked = \(isBookmark) where vnum = \(id) AND bcode = '\(bcode)' AND cnum = '\(cnum)' AND vcode = '\(vcode)'"
        
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
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("삽입하는데 실패했다: \(errmsg)")
            return
        }
    }
    
    public func getCurrentBible() -> Bible {
        let queryString = "SELECT * FROM bibles where vcode = '\(vcode)' AND bcode = '\(bcode)'"
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
        
        return bibleList.first!
    }
    
    public func getVersesFromDB(_ queryString: String) -> [Verse] {
        var verseList = [Verse]()
        
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
            let cnum = String(cString: sqlite3_column_text(stmt, 3))
            let vnum = String(cString: sqlite3_column_text(stmt, 4))
            let content = String(cString: sqlite3_column_text(stmt, 5))
            let bookmarked = sqlite3_column_int(stmt, 6)
            
            verseList.append(Verse(id: Int(id), vcode: String(describing: vcode), bcode: Int(bcode), cnum: String(describing: cnum), vnum: String(describing: vnum), content: String(describing: content), bookmarked: Int(bookmarked)))
        }
        
        return verseList
    }
}
