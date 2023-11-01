//
//  Constants.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import UIKit
import EventKit

let kScreenSize = UIScreen.main.bounds
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate


class CommonFunctions: NSObject {
    static func showAlert(_ title : String = "", message : String = "") {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let messageAttributes = [NSAttributedString.Key.font: UIFont.RobotoRegular(size: UIDevice.current.userInterfaceIdiom == .phone ? 15 : 18)]
        let messageString = NSAttributedString(string: message == "" ? title : message, attributes: messageAttributes)
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        if var topController = UIWindow.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true, completion: nil)
        }
    }
}
