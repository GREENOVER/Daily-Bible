//
//  Song.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/03.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Song: Hashable, Codable, Identifiable {
    public var id: Int
    public var version: String
    public var type: String
    public var number: String
    public var title: String
    
    public init(id: Int, version: String, type: String, number: String, title: String) {
        self.id = id
        self.version = version
        self.type = type
        self.number = number
        self.title = title
    }
}
