//
//  Track.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import UIKit

public struct Track {
    public var title: String
    public var artist: String
    public var artworkImage = UIImage(named: "jesus")
    
    public init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}
