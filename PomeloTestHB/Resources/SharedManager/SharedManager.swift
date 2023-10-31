//
//  SharedManager.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import UIKit
class SharedManager: NSObject {
    static let sharedInstance = SharedManager()
    static func shared() -> SharedManager {
        return sharedInstance
    }
    override init() {
        super.init()
    }
}
