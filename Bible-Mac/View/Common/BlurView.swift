//
//  BlurView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2021/11/11.
//  Copyright © 2021 jge. All rights reserved.
//

import SwiftUI

struct BlurView: NSViewRepresentable {
    func makeNSView(context: Context) -> some NSView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}
