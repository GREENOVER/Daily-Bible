//
//  NumberListView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct NumberListView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Binding var dismissAll: Bool
    let bible: Bible
    
    var body: some View {
        WaterfallGrid(1..<bible.chapterCount + 1, id: \.self) { number in
            numberGridView(text: String(number))
                .onTapGesture {
                    gridTapped(number)
                }
        }.gridStyle(columns: 4, spacing: 10)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            .padding(.top, 20)
    }
    
    private func gridTapped(_ number: Int) {
        UserDefaults.standard.set("\(bible.bcode)", forKey: "bcode")
        UserDefaults.standard.set("\(number)", forKey: "cnum")
        self.presentationMode.wrappedValue.dismiss()
        self.dismissAll = true
    }
}

struct NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NumberListView(dismissAll: .constant(false), bible: Bible(id: 0, vcode: "", bcode: 0, type: "", name: "", chapterCount: 50))
            
            NumberListView(dismissAll: .constant(false), bible: Bible(id: 0, vcode: "", bcode: 0, type: "", name: "", chapterCount: 50))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}

struct numberGridView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(Color("Text"))
            .frame(width: 40)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color("Gray")))
    }
}
