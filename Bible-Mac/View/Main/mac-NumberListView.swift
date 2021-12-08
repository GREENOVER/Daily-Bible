//
//  mac-NumberListView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_NumberListView: View {
    @EnvironmentObject var fontManager: FontManager
    @Binding var selectedNumber: Int?
    var bcode: Int
    var chapter_num: Int
    var name: String
    
    let selectedAction: () -> ()
    
    @Namespace private var animation
    
    var body: some View {
        List {
            ForEach(1..<chapter_num + 1, id: \.self) { number in
                ZStack {
                    if selectedNumber == number {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .matchedGeometryEffect(id: "color", in: animation)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.clear)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(String(number) + "장")
                            .font(fontManager.selectedTextStyle)
                    }.padding(.all, 5)
                        .onTapGesture {
                            UserDefaults.standard.set(String(number), forKey: "cnum")
                            self.selectedNumber = number
                            self.selectedAction()
                        }
                }
            }
        }
    }
}

struct mac_NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        mac_NumberListView(selectedNumber: .constant(nil), bcode: 1, chapter_num: 30, name: "창세기", selectedAction: {})
    }
}
