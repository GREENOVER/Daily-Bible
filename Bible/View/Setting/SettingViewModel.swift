//
//  SettingViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine

public class SettingViewModel: ObservableObject {
    @Published var select = UserDefaults.standard.value(forKey: "selectedIndex") as! Int
    @Published var optionsTitle = ["한", "영"]
    @Published var showingAlert = false
    @Published var showModal = false
    
    private var bag = Set<AnyCancellable>()
    
    public init() {
        self.$select
            .dropFirst()
            .sink(receiveValue: {
                print("UserDefaults.standard.value(forKey: selectedIndex) = \($0)")
                if $0 == 0 {
                    UserDefaults.standard.set("GAE", forKey: "vcode")
                    UserDefaults.standard.set(0, forKey: "selectedIndex")
                } else {
                    UserDefaults.standard.set("NIV", forKey: "vcode")
                    UserDefaults.standard.set(1, forKey: "selectedIndex")
                }
            })
            .store(in: &bag)
    }
    
}
