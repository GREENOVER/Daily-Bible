//
//  Daily.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/03.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Daily: Hashable, Codable, Identifiable {
    public var id: Int
    public var bible: String
    public var content: String
    
    public init(id: Int, bible: String, content: String) {
        self.id = id
        self.bible = bible
        self.content = content
    }
    
}
