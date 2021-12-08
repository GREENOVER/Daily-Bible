//
//  readData.swift
//  Bible
//
//  Created by jge on 2020/11/20.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import SQLite3

//let oldBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'GAE' AND type = 'old'")
//let oldEngBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'NIV' AND type = 'old'")
//let newBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'GAE' AND type = 'new'")
//let newEngBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'NIV' AND type = 'new'")
//let gyodokData: [Gyodok] = readGyodok("SELECT * FROM gyodok where sojul = 1")
//let songData: [Song] = readSong("SELECT * FROM hymns")

//let dailyData: [Daily] = readDaily("SELECT * FROM todaybible")

//func getNumber(number: String) -> String {
//    var realNum: String = number
//    if Int(number)! < 10 {
//        realNum = "00" + number
//    } else if Int(number)! > 9 && Int(number)! < 100 {
//        realNum = "0" + number
//    }
//
//    return realNum
//
//}

//let days = getRealDays()
//
//func getRealDays() -> Int {
//    let days = getDate()
//    var newdays: Int
//    if days > 182 {
//        newdays = days - 182
//        return newdays
//    } else {
//        return days
//    }
//}
//
//func getDate() -> Int {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "DD"
//    let defaultTimeZoneStr = formatter.string(from: Date())
//    return Int(defaultTimeZoneStr)!
//}
