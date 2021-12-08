//
//  RadioView.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct RadioView: View {
    @EnvironmentObject var viewModel: RadioViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    Image(uiImage: viewModel.track.artworkImage!)
                        .resizable()
                        .frame(width: UIFrame.UIWidth / 1.5, height: UIFrame.UIWidth / 1.5)
                    
                    if viewModel.isLoaded == false {
                        Text("로딩중입니다...")
                    } else {
                        Text("\(viewModel.track.artist) - \(viewModel.track.title)")
                    }
                }
                
                VStack {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                        .onTapGesture {
                            viewModel.toggle()
                        }
                }
            }.navigationBarTitle("CCM")
        }.navigationViewStyle(.stack)
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RadioView()
                .environmentObject(RadioViewModel())
            
            RadioView()
                .environmentObject(RadioViewModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
