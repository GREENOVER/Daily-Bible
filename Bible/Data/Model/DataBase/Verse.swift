//
//  Verse.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/03.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Verse: Hashable, Codable, Identifiable {
    public var id: Int
    public var vcode: String
    public var bcode: Int
    public var cnum: String
    public var vnum: String
    public var content: String
    public var bookmarked: Int
    
    public init(id: Int, vcode: String, bcode: Int, cnum: String, vnum: String, content: String, bookmarked: Int) {
        self.id = id
        self.vcode = vcode
        self.bcode = bcode
        self.cnum = cnum
        self.vnum = vnum
        self.content = content
        self.bookmarked = bookmarked
    }
}
