//
//  ArticleVM.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import Foundation
import Alamofire
import UIKit
class ArticleVM : NSObject {
    
    var bindToView : ((String) -> ()) = {_ in }
    var bindArticlToView : (() -> ()) = {}
    var articles: [MostPopularResult] = []
    var searchedList: [MostPopularResult] = []
    var searching = false

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
    func filterPopularList(with searchText: String) {
        searchedList = articles.filter {
            return $0.title!.range(of: searchText, options: .caseInsensitive) != nil
        }
        bindArticlToView()
    }
    
    // Implemant search func logic here
    func performSearch(with searchText: String, searchBar: UISearchBar) {
        if !searchText.isEmpty {
            searchedList.removeAll()
            filterPopularList(with: searchText)
            searching = true
            searchBar.enablesReturnKeyAutomatically = false
        } else {
            searching = false
            searchBar.enablesReturnKeyAutomatically = true
            searchBar.text = ""
        }
    }
}
