//
//  SongRepository.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SQLite3

public protocol SongRepository {
    static var songData: [Song] { get }
    static func getSongs() -> [Song]
    func searchSongs(text: String) -> [Song]
    static func getSongsFromDB(_ queryString: String) -> [Song]
}

public final class SongRepositoryImpl: SongRepository {
    public static let songData: [Song] = getSongs()
    
    public init() {}
    
    public static func getSongs() -> [Song] {
        let queryString = "SELECT * FROM hymns"
        
        return getSongsFromDB(queryString)
    }
    
    public func searchSongs(text: String) -> [Song] {
        let queryString = "SELECT * FROM hymns where title LIKE '%\(String(text.components(separatedBy: ["장"]).joined()))%' OR _id LIKE '%\(String(text.components(separatedBy: ["장"]).joined()))%'"
        
        return SongRepositoryImpl.getSongsFromDB(queryString)
    }
    
    public static func getSongsFromDB(_ queryString: String) -> [Song] {
        var songList = [Song]()
        
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
            let version = String(cString: sqlite3_column_text(stmt, 1))
            let type = String(cString: sqlite3_column_text(stmt, 2))
            let number = String(cString: sqlite3_column_text(stmt, 3))
            let title = String(cString: sqlite3_column_text(stmt, 4))
            
            songList.append(Song(id: Int(id), version: String(describing: version), type: String(describing: type), number: String(describing: number), title: String(describing: title)))
        }
        
        return songList
    }
}
