//
//  BibleList.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_BibleListView: View {
    @EnvironmentObject var fontManager: FontManager
    @StateObject private var viewModel = BibleListViewModel()
    
    @State var selectedBible: Bible?
    @State var selectedNumber: Int?
    
    @State var verseVM = VerseViewModel()
    
    @Namespace private var animation
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Group {
                    if selectedBible != nil && selectedNumber != nil {
                        mac_VerseView()
                            .environmentObject(verseVM)
                            .offset(x: 300)
                            .padding(.trailing, 300)
                    }
                }
                
                HStack(spacing: 0) {
                    List(viewModel.bibles, id: \.id) { bible in
                        ZStack {
                            if selectedBible == bible {
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
                            
                            HStack {
                                Text(viewModel.isOld == .old ? String(bible.bcode) : String(bible.bcode - 39))
                                    .font(fontManager.selectedTextStyle)
                                    .padding(.leading, 5)
                                Text(bible.name)
                                    .font(fontManager.selectedTextStyle)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.all, 10)
                            
                        }.onTapGesture {
                            UserDefaults.standard.set(String(bible.bcode), forKey: "bcode")
                            self.selectedBible = bible
                            self.selectedNumber = nil
                        }
                        
                    }.frame(width: 200)
                    
                    Color.black.frame(width: 1)
                    
                    if selectedBible != nil {
                        HStack(spacing: 0) {
                            mac_NumberListView(selectedNumber: $selectedNumber,
                                               bcode: selectedBible!.bcode,
                                               chapter_num: selectedBible!.chapterCount,
                                               name: selectedBible!.name,
                                               selectedAction: { self.verseVM.onAppear() })
                            
                            Color.black.frame(width: 1)
                        }.frame(width: 100)
                    }
                    
                    Spacer()
                }
                .onAppear {
                    viewModel.onAppear()
                    
                    let bcode = UserDefaults.standard.value(forKey: "bcode")
                    let cnum = UserDefaults.standard.value(forKey: "cnum")
                    
                    if bcode != nil && cnum != nil {
                        self.selectedBible = viewModel.bibles.filter { $0.bcode == Int(bcode as! String)! }.first!
                        self.selectedNumber = Int(cnum as! String)!
                    }
                }
            }
        }
    }
}

struct mac_BibleListView_Previews: PreviewProvider {
    static var previews: some View {
        mac_BibleListView().environmentObject(FontManager())
    }
}
