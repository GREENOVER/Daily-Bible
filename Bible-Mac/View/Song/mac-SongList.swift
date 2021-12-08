//
//  mac-SongView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_SongList: View {
    @EnvironmentObject var fontManager: FontManager
    @ObservedObject var viewModel = SongListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $viewModel.search, onEditingChanged: {
                    viewModel.onEditingChanged($0)
                }).textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            List(viewModel.isSearching ? viewModel.searchedSong : SongRepositoryImpl.songData, id: \.id) { song in
                NavigationLink(destination: mac_SongDetail(number: song.number, name: song.title).environmentObject(fontManager)) {
                    Text("\(song.number)장 \(song.title)")
                        .font(fontManager.selectedTextStyle)
                }
            }
            
            Spacer()
        }
    }
}

struct mac_SongList_Previews: PreviewProvider {
    static var previews: some View {
        mac_SongList()
    }
}
