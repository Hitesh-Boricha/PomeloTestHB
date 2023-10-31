//
//  UIViewController+Extension.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//


import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    func pushTo<T: UIViewController>(_ viewController : T) {
        viewController.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func push<T>(_ viewController: T) where T : UIViewController {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 200)) {
            viewController.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    func presentTo<T: UIViewController>(_ viewController : T) {
        viewController.tabBarController?.tabBar.isHidden = true
        self.present(viewController, animated: false, completion: nil)
    }
    
    func popViewController() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
