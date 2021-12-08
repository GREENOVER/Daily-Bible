//
//  GyodokDetailView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct GyodokDetailView: View {
    @State var gyodokDetail = [Gyodok]()
    
    private let jang: Int
    private let title: String
    private let gyodokRepository: GyodokRepository
    
    init(jang: Int,
         title: String,
         gyodokRepository: GyodokRepository = GyodokRepositoryImpl()) {
        self.jang = jang
        self.title = title
        self.gyodokRepository = gyodokRepository
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(gyodokDetail, id: \.self) { gyodok in
                    Text("\(gyodok.sojul). \(gyodok.note)")
                }
            }.frame(width: UIFrame.UIWidth - 40)
        }
        .padding(.top, 20)
        .navigationBarTitle(Text(title), displayMode: .inline)
        .onAppear {
            self.gyodokDetail = gyodokRepository.getDetailGyodoks(jang: self.jang)
        }
    }
}

struct GyodokDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GyodokDetailView(jang: 1, title: "타이틀")
            
            GyodokDetailView(jang: 1, title: "타이틀")
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
