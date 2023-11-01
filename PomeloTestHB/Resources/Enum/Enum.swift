//
//  Enum.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import Foundation
import UIKit

enum AppBaseURL {
    case developemt
//    case staging
//    case production
    var desc : String {
        switch self {
        case .developemt :
            return "https://api.nytimes.com/svc/"
//        case .staging :
//            return "https://api.nytimes.com/svc/"
//        case .production :
//            return "https://api.nytimes.com/svc/"
        }        
    }
}

enum AppAPI {
    case mostPopular
    var url: String {
        switch self {
        case .mostPopular:
            return "mostpopular/v2/emailed/7.json"
        }
    }
}

enum Encoding {
    case JSON
    case URL
}

enum HTTPHeaderField {
    static let authentication  = "Authorization"
    static let contentType     = "Content-Type"
    static let acceptType      = "Accept"
    static let acceptEncoding  = "Accept-Encoding"
    static let acceptLangauge  = "accept-Language"
    static let bearer          = "Bearer"
    static let application     = "Application"
    static let timezone        = "time-zone"
    static let acceptLanguage  = "accept-language"
    static let grantType       = "grant_type"
}

enum ContentType {
    static let json            = "application/json"
    static let multipart       = "multipart/form-data"
    static let urlencoded      = "application/x-www-form-urlencoded"
    static let ENUS            = "en-us"
}

enum MultipartType {
    static let image = "Image"
    static let csv = "CSV"
}

enum MimeType {
    static let image = "image/png"
    static let csvText = "text/csv"
    static let formData = "application/x-www-form-urlencoded"
}
