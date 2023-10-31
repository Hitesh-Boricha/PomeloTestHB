//
//  APIManager.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//


import Foundation
import Alamofire
import UIKit
import IHProgressHUD

class AppAPIManager {
    
    static let shared = AppAPIManager()
    
    private init(){}
    
    // MARK: Almofire Post/Get Request
    func request<T:Decodable>(_ isHUD:Bool = true, url:String, method : HTTPMethod, param:[String:Any]?, header:HTTPHeaders?, file:[String:Any]? = nil, type:T.Type, fullAccess : Bool = false, encoding:Encoding = Encoding.JSON, completion:@escaping (T?,Error?) -> ()) {
        let urlStr : String?
        urlStr = (AppBaseURL.developemt.desc + url).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let urlValues = urlStr, let urls = URL.init(string: urlValues) else {return}
        print("Api Header => \(header ?? [:])")
        print("Api Paramaters => \(String(describing: param))")
        print("Api => \(urls)")
        if Reachability.isConnectedToNetwork() == false {
            CommonFunctions.showAlert("Please check your Internet connection")
            return
        }
        if isHUD {
            IHProgressHUD.show()
        }
        let enc : ParameterEncoding = encoding == Encoding.URL ? URLEncoding.queryString : JSONEncoding.default
        AF.request(urls, method: method, parameters: param != nil ? param! : nil, encoding: enc, headers: header).responseDecodable {  (response: DataResponse<T, AFError>) in
            print("response : \(response)")
            if isHUD {
                IHProgressHUD.dismiss()
            }
            if response.response?.statusCode == 401 || response.response?.statusCode == 403 {
                // implement refresh api functionalities here.
            }
            completion(response.value,response.error)
        }
    }
}
