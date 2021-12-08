//
//  BibleViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/06.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public final class BibleListViewModel: ObservableObject {
    @Published var bibles = [Bible]()
    @Published var isOld: BibleType = .old
    @Published var bibleStatus = ""
    
    private let bibleRepository: BibleRepository
    
    public init(bibleRepository: BibleRepository = BibleRepositoryImpl()) {
        self.bibleRepository = bibleRepository
    }
    
    public func onAppear() {
        self.getBibles()
    }
    
    public func changeTo(isOld: Bool) {
        if isOld {
            UserDefaults.standard.set("old", forKey: "type")
            self.getBibles()
        } else {
            UserDefaults.standard.set("new", forKey: "type")
            self.getBibles()
        }
    }
    
    private func getBibles() {
        #if os(iOS)
        
        self.isOld = BibleType(rawValue: UserDefaults.standard.value(forKey: "type") as! String)!
        self.bibles = self.bibleRepository.getBibles(type: self.isOld)
        self.bibleStatus = (isOld == .old) ? "구약" : "신약"
        
        #else
        
        self.bibles = self.bibleRepository.getAllBibles()
        
        #endif
    }
}
