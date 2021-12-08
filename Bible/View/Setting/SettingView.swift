//
//  SettingView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @ObservedObject var viewModel = SettingViewModel()
    @EnvironmentObject var storeManager: StoreManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("환경설정")) {
                    HStack {
                        Text("성경 한/영 전환")
                        Spacer()
                        Picker("Articles", selection: $viewModel.select) {
                            ForEach(0 ..< viewModel.optionsTitle.count) { index in
                                Text(self.viewModel.optionsTitle[index])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 90)
                    }
                }
                Section(header: Text("북마크")) {
                    NavigationLink(destination: BookmarkView()) {
                        Text("북마크함")
                    }
                }
                
                #if !targetEnvironment(macCatalyst)
                Section(header: Text("구매")) {
                    ForEach(storeManager.myProducts, id: \.self) { product in
                        HStack {
                            Text("오디오 구매")
                            Spacer()
                            if storeManager.isPurchased {
                                Text("구매됨")
                                    .foregroundColor(.green)
                            } else {
                                Button(action: {
                                    storeManager.purchaseProduct(product: product)
                                }) {
                                    Text("구매하기")
                                }
                                .foregroundColor(.blue)
                            }
                        }.onAppear {
                            print(product)
                        }
                    }
                    HStack {
                        Text("구매 복원하기")
                    }.onTapGesture {
                        storeManager.restoreProducts()
                    }
                }
                #endif
                
            }.navigationBarTitle("설정")
        }.navigationViewStyle(.stack)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingView()
            
            SettingView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
                .environment(\.colorScheme, .dark)
        }
    }
}
