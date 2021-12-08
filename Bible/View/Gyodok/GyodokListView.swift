//
//  gyodokListView.swift
//  Bible
//
//  Created by jge on 2020/08/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct GyodokListView: View {
    @ObservedObject var viewModel = GyodokListViewModel()
    
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
                List(viewModel.isSearching ? viewModel.searchedGyodok : GyodokRepositoryImpl.gyodokData, id: \.id) { gyodok in
                    NavigationLink(destination: GyodokDetailView(jang: gyodok.jang, title: gyodok.title)) {
                        Text(gyodok.title)
                    }
                }
            }.navigationBarTitle(Text("교독문"), displayMode: .inline)
        }.navigationViewStyle(.stack)
    }
}

struct gyodokListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GyodokListView()
            
            GyodokListView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
