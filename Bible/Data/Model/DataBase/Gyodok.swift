//
//  Gyodok.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/03.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Gyodok: Hashable, Codable, Identifiable {
    public var id: Int
    public var jang: Int
    public var title: String
    public var sojul: Int
    public var note: String
    
    public init(id: Int, jang: Int, title: String, sojul: Int, note: String) {
        self.id = id
        self.jang = jang
        self.title = title
        self.sojul = sojul
        self.note = note
    }
}
