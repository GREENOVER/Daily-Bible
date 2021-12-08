//
//  BibleList.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BibleListView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State private var dismissAll: Bool = false
    
    @ObservedObject private var viewModel = BibleListViewModel()
    
    var body: some View {
        List(viewModel.bibles, id: \.id) { bible in
            NavigationLink(destination: NumberListView(dismissAll: self.$dismissAll, bible: bible)) {
                HStack {
                    Text(viewModel.isOld == .old ? String(bible.bcode) : String(bible.bcode - 39))
                    Text(bible.name)
                    Spacer()
                    Text("총 \(bible.chapterCount)장")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
        }.onAppear {
            viewModel.onAppear()
            if self.dismissAll == true {
                self.presentationMode.wrappedValue.dismiss()
            }
        }.navigationBarTitle("\(viewModel.bibleStatus)성경 선택", displayMode: .automatic)
            .navigationBarItems(trailing:
                                    HStack(spacing: 20) {
                Text("구약")
                    .foregroundColor(viewModel.isOld == .old ? Color("Text") : .gray)
                    .onTapGesture {
                        viewModel.changeTo(isOld: true)
                    }
                Text("신약")
                    .foregroundColor(viewModel.isOld == .old ? .gray : Color("Text"))
                    .onTapGesture {
                        viewModel.changeTo(isOld: false)
                    }
            })
    }
}

struct BibleListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BibleListView()
            
            BibleListView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
