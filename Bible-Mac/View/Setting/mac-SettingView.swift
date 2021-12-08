//
//  mac-SettingView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_SettingView: View {
    @EnvironmentObject var fontManager: FontManager
    
    @State private var select = UserDefaults.standard.value(forKey: "selectedIndex") as! Int
    @State private var optionsTitle = ["한", "영"]
    @State private var showingAlert = false
    @State private var showModal = false
    
    var body: some View {
        List {
            Section(header: Text("환경설정")) {
                HStack {
                    Text("성경 한/영 전환")
                    Spacer()
                    Picker("", selection: $select) {
                        ForEach(0 ..< optionsTitle.count) { index in
                            Text(self.optionsTitle[index])
                        }
                    }.padding(.trailing, 10)
                    .onReceive([self.select].publisher.first(), perform: { (value) in
                        if value == 0 {
                            UserDefaults.standard.set("GAE", forKey: "vcode")
                            UserDefaults.standard.set(0, forKey: "selectedIndex")
                        } else {
                            UserDefaults.standard.set("NIV", forKey: "vcode")
                            UserDefaults.standard.set(1, forKey: "selectedIndex")
                        }
                    })
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            HStack {
                Text("폰트 변경")
                Spacer()
                selectFontView(selectedTextStyle: $fontManager.selectedTextStyle, textStyle: .body)
                
                selectFontView(selectedTextStyle: $fontManager.selectedTextStyle, textStyle: .title3)
                
                selectFontView(selectedTextStyle: $fontManager.selectedTextStyle, textStyle: .title2)
                
                selectFontView(selectedTextStyle: $fontManager.selectedTextStyle, textStyle: .title)
                
                selectFontView(selectedTextStyle: $fontManager.selectedTextStyle, textStyle: .largeTitle)
            }.padding(.top, 5)
        }
    }
}

struct selectFontView: View {
    @Binding var selectedTextStyle: Font
    let textStyle: Font
    
    var body: some View {
        Text("가")
            .font(textStyle)
            .onTapGesture {
                self.selectedTextStyle = textStyle
            }
            .padding(.all, 10)
            .overlay(
                Group {
                    if selectedTextStyle == textStyle {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    }
                }
            )
    }
}

struct mac_SettingView_Previews: PreviewProvider {
    static var previews: some View {
        mac_SettingView().environmentObject(FontManager())
    }
}
