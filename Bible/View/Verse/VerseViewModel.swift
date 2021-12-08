//
//  VerseViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine
import AVFoundation

public final class VerseViewModel: ObservableObject {
    @Published var verses = [Verse]()
    @Published var isPlaying = false
    @Published var currentBible = Bible(id: 0, vcode: "", bcode: 0, type: "", name: "", chapterCount: 0)
    
    public let player = AVPlayer()
    
    @UserDefault(key: "vcode", defaultValue: "")
    public var vcode: String
    
    private var bag = Set<AnyCancellable>()
    
    @UserDefault(key: "cnum", defaultValue: "")
    private var cnum: String
    
    private let verseRepository: VerseRepository
    
    public init(verseRepository: VerseRepository = VerseRepositoryImpl()) {
        self.verseRepository = verseRepository
        
        self.$isPlaying
            .sink {
                if $0 {
                    self.playRadio()
                } else {
                    self.pauseRadio()
                }
            }.store(in: &bag)
    }
    
    public func onAppear() {
        self.setPlayer()
        self.verses = verseRepository.getVerses()
        #if !os(macOS)
        self.currentBible = verseRepository.getCurrentBible()
        #endif
    }
    
    public func onDisappear() {
        self.player.replaceCurrentItem(with: nil)
    }
    
    public func moveToVerse(isNext: Bool) {
        if isNext {
            if Int(self.verses.first!.cnum)! + 1 != self.currentBible.chapterCount + 1 {
                let plus = Int(self.verses.first!.cnum)! + 1
                self.cnum = String(plus)
                self.verses = verseRepository.getVerses()
                self.setPlayer()
            }
        } else {
            if Int(self.verses.first!.cnum)! - 1 != 0 {
                let minus = Int(self.verses.first!.cnum)! - 1
                self.cnum = String(minus)
                self.verses = verseRepository.getVerses()
                self.setPlayer()
            }
        }
    }
    
    private func setPlayer() {
        guard let url = URL(string: "https://bible.jeonggo.com/audio/\(self.getName()).mp3") else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        self.player.volume = 2
        self.player.replaceCurrentItem(with: playerItem)
    }
    
    public func bookmark(id: Int) {
        verseRepository.updateBookmark(isBookmark: true, id: id)
    }
    
    public func playRadio() {
        player.play()
    }
    
    public func pauseRadio() {
        player.pause()
    }
    
    private func getName() -> String {
        if UserDefaults.standard.value(forKey: "bcode") == nil {
            UserDefaults.standard.set("1", forKey: "bcode")
        }
        if UserDefaults.standard.value(forKey: "cnum") == nil {
            UserDefaults.standard.set("1", forKey: "cnum")
        }
        
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let cnum = UserDefaults.standard.value(forKey: "cnum") as! String
        return Converter.shared.getBibleName(bcode: bcode, cnum: cnum)
    }
}
