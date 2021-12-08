//
//  SettingView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct Tabbar: Hashable, Codable {
    var image: String
    var text: String
}

struct mac_Tabbar: View {
    let tabs = [Tabbar(image: "music.note.list", text: "찬송가"), Tabbar(image: "book.circle", text: "교독문"), Tabbar(image: "heart.circle", text: "북마크"), Tabbar(image: "gear", text: "설정")]
    
    var body: some View {
        VStack {
            ForEach(0...3, id: \.self) { i in
                VStack {
                    Image(systemName: tabs[i].image)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(tabs[i].text)
                        .fixedSize(horizontal: true, vertical: false)
                }.padding(.all, 5)
                .onTapGesture {
                    if i == 0 { NSApp.sendAction(#selector(AppDelegate.openSongWindow), to: nil, from: nil) }
                    if i == 1 { NSApp.sendAction(#selector(AppDelegate.openGyodokView), to: nil, from: nil) }
                    if i == 2 { NSApp.sendAction(#selector(AppDelegate.openBookmarkView), to: nil, from: nil) }
                    if i == 3 { NSApp.sendAction(#selector(AppDelegate.openSettingView), to: nil, from: nil) }
                }
            }
            
            Spacer()
        }.padding(.top, 10)
    }
}

struct mac_TapBar_Previews: PreviewProvider {
    static var previews: some View {
        mac_Tabbar()
    }
}
