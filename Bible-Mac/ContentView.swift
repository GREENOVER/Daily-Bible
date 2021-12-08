//
//  ContentView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/03.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fontManager: FontManager
    
    var body: some View {
        HStack(spacing: 0) {
            mac_Tabbar()
                .frame(maxWidth: 60)
                .background(BlurView())
            
            Color.black.frame(width: 1)
            
            mac_BibleListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
