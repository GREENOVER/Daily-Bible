//
//  SongListViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/06.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine

public final class SongListViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var isSearching = false
    
    @Published var searchedSong = [Song]()
    
    private let songRepository: SongRepository
    private var bag = Set<AnyCancellable>()
    
    public init(songRepository: SongRepository = SongRepositoryImpl()) {
        self.songRepository = songRepository
    }
    
    public func onEditingChanged(_ changed: Bool) {
        if changed == false {
            if self.search == "" {
                self.isSearching = false
            } else {
                self.isSearching = true
                self.searchedSong = self.songRepository.searchSongs(text: self.search)
            }
        }
    }
}
