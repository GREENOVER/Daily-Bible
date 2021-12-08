//
//  FontManager.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2021/11/11.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class FontManager: ObservableObject {
    @Published var selectedTextStyle: Font = .body
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.setSelectedTextStyle()
        
        self.$selectedTextStyle
            .sink(receiveValue: {
                UserDefaults.standard.set(self.getSelectedTextStyle($0), forKey: "selectedTextStyle")
            })
            .store(in: &bag)
    }
    
    private func getSelectedTextStyle(_ font: Font) -> String {
        switch font {
        case .body:
            return "body"
        case .title3:
            return "title3"
        case .title2:
            return "title2"
        case .title:
            return "title"
        case .largeTitle:
            return "largeTitle"
        default:
            return "body"
        }
    }
    
    private func setSelectedTextStyle() {
        if UserDefaults.standard.value(forKey: "selectedTextStyle") == nil {
            UserDefaults.standard.set("body", forKey: "selectedTextStyle")
        }
        
        switch UserDefaults.standard.value(forKey: "selectedTextStyle") as! String {
        case "body":
            self.selectedTextStyle = .body
        case "title3":
            self.selectedTextStyle = .title3
        case "title2":
            self.selectedTextStyle = .title2
        case "title":
            self.selectedTextStyle = .title
        case "largeTitle":
            self.selectedTextStyle = .largeTitle
        default:
            self.selectedTextStyle = .body
        }
    }
}
