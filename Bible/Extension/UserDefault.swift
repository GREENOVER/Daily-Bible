//
//  UserDefaults.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct UserDefault<Value> {
    private let key: String
    private let defaultValue: Value
    private let UD: UserDefaults
    private let lock = NSLock()
    
    public init(key: String, defaultValue: Value, UD: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.UD = UD
    }
    
    public var wrappedValue: Value {
        get {
            lock.withLock {
                return UD.object(forKey: key) as? Value ?? defaultValue
            }
        }
        set {
            lock.withLock {
                UD.set(newValue, forKey: key)
            }
        }
    }
}
