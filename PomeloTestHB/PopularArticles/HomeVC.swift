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
    private var articleModel : ArticleVM?
    var popularList = [MostPopularResult]()
    var searchedList: [MostPopularResult] = []
    var searching = false
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
        popularList.sort(by: { $0.updated!.compare($1.updated!) == .orderedDescending })
        DispatchQueue.main.async {
            self.tblPopularList.reloadData()
        }
    }
    
    // MARK: - Api calls
    func callMostPopularApi() {
        self.articleModel?.getAllMostPopularArticles()
        self.articleModel?.bindArticlToView = { [unowned self] in
            self.popularList = self.articleModel?.articles ?? [MostPopularResult]()
            sortPopularList()
        }
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if searching {
            return searchedList.count
        } else {
            return popularList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularListCell.reuseID(), for: indexPath) as? PopularListCell else { return UITableViewCell() }
        if searching {
            let list = searchedList[indexPath.row]
            cell.setPopularList(list: list)
            if list.media!.count > 0 {
                if list.media![0].mediaList!.count > 0 {
                    if let url = list.media?[0].mediaList?[0].url {
                        imageUrl = url
                    }
                }
            }
        } else {
            let list = popularList[indexPath.row]
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
        let destinationVC = WebViewVC.instantiate(fromAppStoryboard: .main)
        if searching {
            let obj = searchedList[indexPath.row]
            if let urlDetails = obj.url {
                destinationVC.urlAddress = urlDetails
            }
        } else {
            let obj = popularList[indexPath.row]
            if let urlDetails = obj.url {
                destinationVC.urlAddress = urlDetails
            }
        }
        self.pushTo(destinationVC)
    }
}

extension HomeVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        searchBar.enablesReturnKeyAutomatically = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchBar.enablesReturnKeyAutomatically = false
            searchedList.removeAll()
            searchedList = popularList.filter {
                return $0.title!.range(of: searchText, options: .caseInsensitive) != nil
            }
            searching = true
        } else {
            searching = false
            searchBar.enablesReturnKeyAutomatically = true
            searchBar.text = ""
        }
        tblPopularList.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
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
