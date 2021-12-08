//
//  UIApplication+ShareText.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/06.
//  Copyright © 2021 jge. All rights reserved.
//

import UIKit

extension UIApplication {
    static func showShareText(text: String) {
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        if let popoverController = av.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
