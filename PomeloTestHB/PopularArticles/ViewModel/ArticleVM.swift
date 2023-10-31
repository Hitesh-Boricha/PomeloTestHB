//
//  ArticleVM.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import Foundation
import Alamofire
class ArticleVM : NSObject {
    
    var bindToView : ((String) -> ()) = {_ in }
    var bindArticlToView : (() -> ()) = {}
    var articles : [MostPopularResult]?
    
    func getAllMostPopularArticles()  {
        let param = [
            "api-key" : "VEkySdjGQhEMyPp4NL3pQoXPX9GNAKk3"
        ]
        AppAPIManager.shared.request(url: AppAPI.mostPopular.url, method: .get, param: param, header: nil, type: PopularModel.self,encoding:.URL) { response, error in
            guard let data = response?.results, error == nil else {
                CommonFunctions.showAlert("Something went wrong!!")
                return
            }
            self.articles = data
            self.bindArticlToView()
        }
    }
}
