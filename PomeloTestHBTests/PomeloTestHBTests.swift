//
//  PomeloTestHBTests.swift
//  PomeloTestHBTests
//
//  Created by Hitesh Boricha on 31/10/23.
//

import XCTest
@testable import PomeloTestHB
final class PomeloTestHBTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
            if !articleModel.articles!.isEmpty {
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
}
