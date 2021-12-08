//
//  SongListView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $viewModel.search, onEditingChanged: {
                        viewModel.onEditingChanged($0)
                    }).textFieldStyle(RoundedBorderTextFieldStyle())
                }.padding(.horizontal, 20)
                    .padding(.vertical, 10)
                List(viewModel.isSearching ? viewModel.searchedSong : SongRepositoryImpl.songData, id: \.id) { song in
                    NavigationLink(destination: SongDetailView(number: song.number, name: song.title)) {
                        Text("\(song.number)장 \(song.title)")
                    }
                }
            }.navigationBarTitle(Text("찬송가"), displayMode: .inline)
        }.navigationViewStyle(.stack)
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SongListView()
            
            SongListView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
