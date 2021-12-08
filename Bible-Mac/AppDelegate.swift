//
//  AppDelegate.swift
//  AllDevices-macOS
//
//  Created by jge on 2020/07/23.
//  Copyright © 2020 jge. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    var songWindow: NSWindow!
    var imageWindow: NSWindow!
    var settingWindow: NSWindow!
    var gyodokWindow: NSWindow!
    var bookmarkWindow: NSWindow!
    
    let fontManager = FontManager()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.setUp()
        
        // MARK: View Appear
        
        let contentView = ContentView().environmentObject(fontManager)
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func openSongWindow() {
        if nil == songWindow {
            let songView = mac_SongView().environmentObject(fontManager)
            // Create the preferences window and set content
            songWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            songWindow.center()
            songWindow.setFrameAutosaveName("songView")
            songWindow.isReleasedWhenClosed = false
            songWindow.contentView = NSHostingView(rootView: songView)
        }
        songWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openImageWindow() {
        let imageView = mac_ImageView()
        // Create the preferences window and set content
        imageWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        imageWindow.center()
        imageWindow.setFrameAutosaveName("imageView")
        imageWindow.isReleasedWhenClosed = false
        imageWindow.contentView = NSHostingView(rootView: imageView)
        imageWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openSettingView() {
        if nil == settingWindow {
            let settingView = mac_SettingView().environmentObject(fontManager)
            // Create the preferences window and set content
            settingWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 300, height: 300),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            settingWindow.center()
            settingWindow.setFrameAutosaveName("settingView")
            settingWindow.isReleasedWhenClosed = false
            settingWindow.contentView = NSHostingView(rootView: settingView)
        }
        settingWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openGyodokView() {
        if nil == gyodokWindow {
            let gyodokView = mac_GyodokView().environmentObject(fontManager)
            // Create the preferences window and set content
            gyodokWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            gyodokWindow.center()
            gyodokWindow.setFrameAutosaveName("gyodokView")
            gyodokWindow.isReleasedWhenClosed = false
            gyodokWindow.contentView = NSHostingView(rootView: gyodokView)
        }
        gyodokWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openBookmarkView() {
        let bookmarkView = mac_BookmarkView().environmentObject(fontManager)
        // Create the preferences window and set content
        bookmarkWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        bookmarkWindow.center()
        bookmarkWindow.setFrameAutosaveName("gyodokView")
        bookmarkWindow.isReleasedWhenClosed = false
        bookmarkWindow.contentView = NSHostingView(rootView: bookmarkView)
        bookmarkWindow.makeKeyAndOrderFront(nil)
    }
    
    func setUp() {
        if UserDefaults.standard.value(forKey: "vcode") == nil {
            UserDefaults.standard.set("GAE", forKey: "vcode")
        }
        if UserDefaults.standard.value(forKey: "bcode") == nil {
            UserDefaults.standard.set("1", forKey: "bcode")
        }
        if UserDefaults.standard.value(forKey: "cnum") == nil {
            UserDefaults.standard.set("1", forKey: "cnum")
        }
        if UserDefaults.standard.value(forKey: "selectedTextStyle") == nil {
            UserDefaults.standard.set("body", forKey: "selectedTextStyle")
        }
        if UserDefaults.standard.value(forKey: "selectedIndex") == nil {
            UserDefaults.standard.set(0, forKey: "selectedIndex")
        }
    }
}
