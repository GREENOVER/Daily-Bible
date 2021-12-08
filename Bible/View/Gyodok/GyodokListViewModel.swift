//
//  GyodokListViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/06.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine

public final class GyodokListViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var isSearching = false
    
    @Published var searchedGyodok = [Gyodok]()
    
    private let gyodokRepository: GyodokRepository
    private var bag = Set<AnyCancellable>()
    
    public init(gyodokRepository: GyodokRepository = GyodokRepositoryImpl()) {
        self.gyodokRepository = gyodokRepository
    }
    
    public func onEditingChanged(_ changed: Bool) {
        if changed == false {
            if self.search == "" {
                self.isSearching = false
            } else {
                self.isSearching = true
                self.searchedGyodok = self.gyodokRepository.searchGyodoks(text: self.search)
            }
        }
    }
}
