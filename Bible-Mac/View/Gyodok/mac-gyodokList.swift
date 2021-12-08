//
//  mac-gyodokList.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_gyodokList: View {
    @EnvironmentObject var fontManager: FontManager
    @ObservedObject var viewModel = GyodokListViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $viewModel.search, onEditingChanged: {
                    viewModel.onEditingChanged($0)
                }).textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            List(viewModel.isSearching ? viewModel.searchedGyodok : GyodokRepositoryImpl.gyodokData, id: \.id) { gyodok in
                NavigationLink(destination: mac_gyodokDetail(jang: gyodok.jang, title: gyodok.title).environmentObject(fontManager)) {
                    Text(gyodok.title)
                        .font(fontManager.selectedTextStyle)
                }
            }
        }
    }
}

struct gyodokListView_Previews: PreviewProvider {
    static var previews: some View {
        mac_gyodokList()
    }
}
