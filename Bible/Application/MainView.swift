//
//  MainView.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var storeManager: StoreManager
    let radioVM = RadioViewModel()
    
    var body: some View {
        TabView {
            VerseView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("성경")
                }

            SongListView()
                .tabItem {
                    Image(systemName: "music.note")
                    Text("찬송가")
                }
            
            GyodokListView()
                .tabItem {
                    Image(systemName: "book.circle")
                    Text("교독문")
                }
            
            RadioView()
                .environmentObject(radioVM)
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("CCM")
                }
            
            SettingView()
                .environmentObject(storeManager)
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
