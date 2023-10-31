//
//  String+Extension.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import Foundation

extension String {
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        let finalDate = dateFormatter.string(from: date!)
        return finalDate
    }

}
