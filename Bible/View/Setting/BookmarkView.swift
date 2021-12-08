//
//  BookmarkView.swift
//  Bible
//
//  Created by jge on 2020/11/22.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BookmarkView: View {
    @ObservedObject private var viewModel = BookmarkViewModel()
    
    var body: some View {
        Group {
            if viewModel.verses.isEmpty {
                Text("아직 북마크한 구절이 없습니다.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(viewModel.verses, id: \.id) { verse in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(verse.content)
                                HStack {
                                    if viewModel.vcode == "NIV" {
                                        Text(BibleNames.englishBibles[verse.bcode - 1])
                                            .fixedSize(horizontal: true, vertical: false)
                                    } else {
                                        Text(BibleNames.koreaBibles[verse.bcode - 1])
                                            .fixedSize(horizontal: true, vertical: false)
                                    }
                                    Text("\(verse.cnum)장")
                                    Text("\(verse.vnum)절")
                                }.foregroundColor(.gray)
                            }
                            Spacer()
                            ZStack(alignment: .center) {
                                Circle().foregroundColor(.red)
                                Image(systemName: "minus")
                                    .foregroundColor(.white)
                            }.frame(width: 18, height: 18)
                            .onTapGesture {
                                viewModel.unBookmark(id: Int(verse.vnum)!)
                            }
                            
                        }.padding([.top, .bottom], 5)
                        .contextMenu {
                            Button(action: {
                                UIApplication.showShareText(text: verse.content)
                            }) {
                                Text("공유")
                                Image(systemName: "square.and.arrow.up")
                            }
                            Button(action: {
                                viewModel.unBookmark(id: Int(verse.vnum)!)
                            }) {
                                Image(systemName: "heart")
                                Text("북마크 취소")
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
            }
        }
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookmarkView()
            
            BookmarkView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
