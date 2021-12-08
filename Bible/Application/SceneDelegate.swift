//
//  SceneDelegate.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import UIKit
import SwiftUI
import StoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let fileManager = FileManager.default
        
        guard let documentsUrl = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.com.jeonggo.sqlite") else {
                return
        }
        
        let finalDatabaseURL = documentsUrl.appendingPathComponent("holybible.db")
        
        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "holybible", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                    self.setUp()
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
        
        let storeManager = StoreManager()
        
        SKPaymentQueue.default().add(storeManager)
        storeManager.getProducts(productIDs: ["com.jeonggo.Bible.audio"])
        
        let contentView = MainView()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(storeManager))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func setUp() {
        UserDefaults.standard.set("GAE", forKey: "vcode")
        UserDefaults.standard.set("1", forKey: "bcode")
        UserDefaults.standard.set("1", forKey: "cnum")
        UserDefaults.standard.set("old", forKey: "type")
        UserDefaults.standard.set(0, forKey: "selectedIndex")
    }

}
