//
//  mac-SongView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_SongView: View {
    @EnvironmentObject var fontManager: FontManager
    
    var body: some View {
        HStack {
            NavigationView {
                mac_SongList()
                    .frame(minWidth: 250, maxWidth: 250)
                    .environmentObject(fontManager)
            }
        }.frame(minWidth: 900, minHeight: 600)
    }
}

struct mac_SongView_Previews: PreviewProvider {
    static var previews: some View {
        mac_SongView()
    }
}
