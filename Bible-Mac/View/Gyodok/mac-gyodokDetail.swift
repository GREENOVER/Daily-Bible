//
//  mac-gyodokDetail.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_gyodokDetail: View {
    @EnvironmentObject var fontManager: FontManager
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
        List {
            Text("\(title)")
                .font(.title)
                .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(gyodokDetail, id: \.self) { gyodok in
                    Text("\(gyodok.sojul). \(gyodok.note)")
                        .font(fontManager.selectedTextStyle)
                        .padding(.all, 3)
                }
            }
        }
        .padding(.top, 20)
        .onAppear {
            self.gyodokDetail = gyodokRepository.getDetailGyodoks(jang: self.jang)
        }
    }
}

struct mac_gyodokDetail_Previews: PreviewProvider {
    static var previews: some View {
        mac_gyodokDetail(jang: 1, title: "타이틀")
    }
}
