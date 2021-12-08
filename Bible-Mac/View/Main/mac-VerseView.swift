//
//  currentVerseView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//
import SwiftUI
import StoreKit
import AVFoundation

struct mac_VerseView: View {
    @EnvironmentObject var fontManager: FontManager
    @EnvironmentObject private var viewModel: VerseViewModel
    
    var body: some View {
        List {
            HStack(spacing: 5) {
                Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        self.viewModel.isPlaying.toggle()
                    }
                
                AudioPlayerControlsView(player: viewModel.player,
                                        timeObserver: PlayerTimeObserver(player: viewModel.player),
                                        durationObserver: PlayerDurationObserver(player: viewModel.player),
                                        itemObserver: PlayerItemObserver(player: viewModel.player))
                    .environmentObject(fontManager)
                
            }.padding(.leading, 15)
                .padding(.trailing, 15)
            
            ForEach(viewModel.verses, id: \.id) { verse in
                HStack(alignment: .top) {
                    VStack {
                        Text(verse.vnum)
                    }
                    Text(verse.content)
                        .fixedSize(horizontal: false, vertical: true)
                }.font(fontManager.selectedTextStyle)
                    .padding(.all, 3)
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
                            viewModel.bookmark(id: Int(verse.vnum)!)
                        }) {
                            Image(systemName: "heart.fill")
                            Text("북마크")
                        }
                    }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
    }
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        mac_VerseView()
    }
}
