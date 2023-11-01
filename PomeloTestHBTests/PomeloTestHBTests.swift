//
//  PomeloTestHBTests.swift
//  PomeloTestHBTests
//
//  Created by Hitesh Boricha on 31/10/23.
//

import XCTest
@testable import PomeloTestHB
import WebKit
final class PomeloTestHBTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        super.tearDown()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testApiCall() {
        let expectations = expectation(description: "Alamofire")
        let articleModel = ArticleVM()
        articleModel.getAllMostPopularArticles()
        articleModel.bindArticlToView = {
            if !articleModel.articles.isEmpty {
                XCTAssertNotNil(articleModel.articles, "The result array is not empty")
            } else {
                XCTAssertNil(articleModel.articles, "The result array is empty")
            }
            expectations.fulfill()
        }
        waitForExpectations(timeout: 10, handler: { (error) in
            if let error = error {
                print("Failed : \(error.localizedDescription)")
            }
        })
    }
    
    func testSearchBarShouldBeginEditingReturnsTrue() {
        let homeVC = HomeVC()
        let searchBar = UISearchBar()
        let result = homeVC.searchBarShouldBeginEditing(searchBar)
        XCTAssertTrue(result)
        XCTAssertTrue(searchBar.showsCancelButton)
        XCTAssertTrue(searchBar.enablesReturnKeyAutomatically)
    }
    func testSearchBarTextDidChange() {
        let homeVC = HomeVC()
        let searchBar = UISearchBar()
        let articleModel = ArticleVM()
        homeVC.articleModel = articleModel
        let tableView = UITableView()
        homeVC.tblPopularList = tableView
        homeVC.searchBar(searchBar, textDidChange: "TestSearchText")
        XCTAssertTrue(articleModel.searching)
    }
    func testSearchBarCancelButtonClicked() {
        let homeVC = HomeVC()
        let searchBar = UISearchBar()
        let articleModel = ArticleVM()
        homeVC.articleModel = articleModel
        let tableView = UITableView()
        homeVC.tblPopularList = tableView
        homeVC.searchBarCancelButtonClicked(searchBar)
        
        XCTAssertFalse(articleModel.searching)
        XCTAssertEqual(searchBar.text, "")
        XCTAssertFalse(searchBar.showsCancelButton)
    }
    func testSearchBarSearchButtonClicked() {
        let homeVC = HomeVC()
        let searchBar = UISearchBar()
        homeVC.searchBarSearchButtonClicked(searchBar)
        XCTAssertFalse(searchBar.showsCancelButton)
    }
    func testRobotoRegularFont() {
        let fontSize: CGFloat = 16.0
        let font = UIFont.RobotoRegular(size: fontSize)
        XCTAssertEqual(font.fontName, "Roboto-Regular")
        XCTAssertEqual(font.pointSize, fontSize)
    }
    
    func testAddActivityIndicatorView() {
        let objweb = WebViewVC()
        let activity = UIActivityIndicatorView()
        let webView = WKWebView()
        objweb.activity = activity
        objweb.webView = webView
        objweb.addActivityIndicatorView()
        XCTAssertTrue(objweb.activity.isAnimating)
        XCTAssertTrue(objweb.webView.navigationDelegate === objweb)
        XCTAssertTrue(objweb.activity.hidesWhenStopped)
    }
    
    func testDecidePolicyForNavigationAction() {
        let objweb = WebViewVC()
        let webView = WKWebView()
        let navigationAction = WKNavigationAction()
        let expectation = XCTestExpectation(description: "Decide policy expectation")
        objweb.webView(webView, decidePolicyFor: navigationAction) { policy in
            XCTAssertEqual(policy, .allow)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testShowAlertWithCustomTitleAndMessage() {
        // Arrange
        let expectedTitle = "Custom Title"
        let expectedMessage = "This is a custom message"
        
        // Act
        CommonFunctions.showAlert(expectedTitle, message: expectedMessage)
        
        // Assert
        // You can't directly assert UIAlertControllers and their titles or messages,
        // so you may need to use UI testing to validate the displayed alert.
    }

    
    @available(iOS 13, *)
    func testKeyWindowOniOS13AndLater() {
        // Arrange
        let window1 = UIWindow()
        let appDelegate = AppDelegate()
        appDelegate.window = window1
        appDelegate.window?.makeKey()
        let keyWindow = UIWindow.keyWindow
        XCTAssertEqual(keyWindow, appDelegate.window, "The key window should be the first window that is made key.")
    }
    
}
