//
//  mac-BookmarkView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2021/11/11.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct mac_BookmarkView: View {
    @EnvironmentObject var fontManager: FontManager
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
                                    .font(fontManager.selectedTextStyle)
                                
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
                                let pasteboard = NSPasteboard.general
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString("\(verse.content) - \((viewModel.vcode == "NIV") ? BibleNames.englishBibles[verse.bcode - 1] : BibleNames.koreaBibles[verse.bcode - 1]) \(verse.cnum)장 \(verse.vnum)절", forType: .string)
                            }) {
                                Text("복사")
                                Image(systemName: "doc.on.doc")
                            }
                            Button(action: {
                                viewModel.unBookmark(id: Int(verse.vnum)!)
                            }) {
                                Image(systemName: "heart")
                                Text("북마크 취소")
                            }
                        }
                    }
                }
            }
        }
        .frame(minWidth: 900, minHeight: 600)
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

struct mac_BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        mac_BookmarkView()
    }
}
