//
//  HomeVC.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//


import UIKit
import Kingfisher

class HomeVC: UIViewController {
    
    @IBOutlet var tblPopularList: UITableView!
    @IBOutlet weak var popularSearchbar: UISearchBar!
    var articleModel: ArticleVM = ArticleVM()
    var imageUrl = ""
    
    override func loadView() {
        super.loadView()
        articleModel = ArticleVM()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        popularSearchbar.delegate = self
        callMostPopularApi()
    }
    
    func sortPopularList() {
        articleModel.articles.sort(by: { $0.updated!.compare($1.updated!) == .orderedDescending })
        DispatchQueue.main.async {
            self.tblPopularList.reloadData()
        }
    }
    
    // MARK: - Api calls
    func callMostPopularApi() {
        self.articleModel.getAllMostPopularArticles()
        self.articleModel.bindArticlToView = { [unowned self] in
            sortPopularList()
        }
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if articleModel.searching {
            return articleModel.searchedList.count
        } else {
            return articleModel.articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularListCell.reuseID(), for: indexPath) as? PopularListCell else { return UITableViewCell() }
        if articleModel.searching {
            let list = articleModel.searchedList[indexPath.row]
            cell.setPopularList(list: list)
            if list.media!.count > 0 {
                if list.media![0].mediaList!.count > 0 {
                    if let url = list.media?[0].mediaList?[0].url {
                        imageUrl = url
                    }
                }
            }
        } else {
            let list = articleModel.articles[indexPath.row]
            cell.setPopularList(list: list)
            if let url = list.media?[0].mediaList?[0].url {
                imageUrl = url
            }
        }
        if let url = URL(string: imageUrl) {
            let processor = DownsamplingImageProcessor(size: (cell.imgArticle.bounds.size))
            |> RoundCornerImageProcessor(cornerRadius: 2)
            cell.imgArticle.kf.indicatorType = .activity
            cell.imgArticle.kf.setImage(
                with: url,
                placeholder: UIImage(named: ""),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                ]
            )
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let objWeb = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as? WebViewVC else { return }
        if articleModel.searching {
            let obj = articleModel.searchedList[indexPath.row]
            objWeb.urlAddress = obj.url!
        } else {
            let obj = articleModel.articles[indexPath.row]
            objWeb.urlAddress = obj.url!
        }
        self.navigationController?.pushViewController(objWeb, animated: true)
    }
}

extension HomeVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        searchBar.enablesReturnKeyAutomatically = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        articleModel.performSearch(with: searchText, searchBar: searchBar)
        tblPopularList.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        articleModel.searching = false
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.searchTextField.endEditing(true)
        tblPopularList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.searchTextField.endEditing(true)
    }
}
