//
//  Bible.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/03.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Bible: Hashable, Codable, Identifiable {
    public var id: Int
    public var vcode: String
    public var bcode: Int
    public var type: String
    public var name: String
    public var chapterCount: Int
    
    public init(id: Int, vcode: String, bcode: Int, type: String, name: String, chapterCount: Int) {
        self.id = id
        self.vcode = vcode
        self.bcode = bcode
        self.type = type
        self.name = name
        self.chapterCount = chapterCount
    }
}
