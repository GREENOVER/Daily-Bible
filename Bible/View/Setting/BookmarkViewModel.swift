//
//  BookmarkViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/06.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public final class BookmarkViewModel: ObservableObject {
    @Published var verses = [Verse]()
    
    @UserDefault(key: "vcode", defaultValue: "")
    public var vcode: String
    
    private let verseRepository: VerseRepository
    
    public init(verseRepository: VerseRepository = VerseRepositoryImpl()) {
        self.verseRepository = verseRepository
    }
    
    public func onAppear() {
        self.verses = self.verseRepository.getBookmarkedVerses()
    }
    
    public func unBookmark(id: Int) {
        verseRepository.updateBookmark(isBookmark: false, id: id)
        self.onAppear()
    }
}
