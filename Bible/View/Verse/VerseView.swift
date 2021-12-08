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

struct VerseView: View {
    @StateObject private var viewModel = VerseViewModel()
    
    @State private var offset = CGSize.zero
    @State var ShareSheet = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    HStack(spacing: 5) {
                        Image(systemName: viewModel.isPlaying ? "pause.circle" : "play.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                self.viewModel.isPlaying.toggle()
                            }
                        AudioPlayerControlsView(player: viewModel.player,
                                                timeObserver: PlayerTimeObserver(player: viewModel.player),
                                                durationObserver: PlayerDurationObserver(player: viewModel.player),
                                                itemObserver: PlayerItemObserver(player: viewModel.player))
                    }.padding(.leading, 15)
                        .padding(.trailing, 15)
                        .foregroundColor(UserDefaults.standard.bool(forKey: "isPurchased") ? Color("Text") : .gray)
                    
                    ForEach(viewModel.verses, id: \.id) { verse in
                        HStack(alignment: .top) {
                            VStack {
                                Text(verse.vnum)
                            }
                            Text(verse.content)
                        }.contextMenu {
                            Button(action: {
                                UIApplication.showShareText(text: verse.content)
                            }) {
                                Text("공유")
                                Image(systemName: "square.and.arrow.up")
                            }
                            Button(action: {
                                viewModel.bookmark(id: Int(verse.vnum)!)
                            }) {
                                Image(systemName: "heart.fill")
                                Text("북마크하기")
                            }
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
            .navigationBarTitle(Text("\(viewModel.currentBible.name) \(viewModel.verses.first?.cnum ?? "0")장"), displayMode: .automatic)
            .navigationBarItems(trailing:
                                    HStack(spacing: 20) {
                NavigationLink(destination: BibleListView()) {
                    imageView(imageName: "list.dash", isSystem: true)
                }
                imageView(imageName: "arrowtriangle.left", isSystem: true)
                    .onTapGesture {
                        viewModel.moveToVerse(isNext: false)
                    }
                imageView(imageName: "arrowtriangle.right", isSystem: true)
                    .onTapGesture {
                        viewModel.moveToVerse(isNext: true)
                    }
            })
        }
        .navigationViewStyle(.stack)
    }
    
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VerseView()
            
            VerseView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}

struct imageView: View {
    let imageName: String
    let isSystem: Bool
    var body: some View {
        VStack {
            if isSystem {
                Image(systemName: "\(imageName)")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("Text"))
            } else {
                Image(imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("Text"))
            }
        }
    }
}

struct barView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("Text"))
            Text(text)
                .foregroundColor(Color("Text"))
            
        }
    }
}
