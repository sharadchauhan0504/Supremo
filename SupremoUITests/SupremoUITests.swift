//
//  SupremoUITests.swift
//  SupremoUITests
//
//  Created by Sharad on 14/11/20.
//

import XCTest

class SupremoUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testAppFlow() throws {
        app.launch()
        
        //HomeScreenController
        let homeScreenControllerView = app.otherElements["controller--HomeScreenController"]
        XCTAssertTrue(homeScreenControllerView.exists)

        let recentSearchTableView    = homeScreenControllerView.tables["tableview--recentSearchTableView"]
        XCTAssertTrue(recentSearchTableView.exists)

        wait(1.0)

        let searchIconBarButton      = app.navigationBars.buttons["button--searchIconBarButton"]
        XCTAssertTrue(searchIconBarButton.exists)
        searchIconBarButton.tap()
        
        //SearchScreenController
        let searchScreenControllerView = app.otherElements["controller--SearchScreenController"]
        XCTAssertTrue(searchScreenControllerView.exists)

        wait(1.0)
        let searchBar                  = searchScreenControllerView.searchFields["searchbar--searchBar"]
        XCTAssertTrue(searchBar.exists)
        
        searchBar.typeText("batman")
        app.buttons["Search"].tap()
        
        wait(3.0)
        
        let searchListingCell = searchScreenControllerView.tables.cells["tablecell--SearchListTableCell"].firstMatch
        XCTAssertTrue(searchListingCell.exists)
        searchListingCell.tap()
        
        wait(1.0)
        
        //CharacterDetailScreenController
        let characterDetailScreenControllerView = app.otherElements["controller--CharacterDetailScreenController"]
        XCTAssertTrue(characterDetailScreenControllerView.exists)

        let characterDetailsTableView           = characterDetailScreenControllerView.tables["tableview--characterDetailsTableView"]
        XCTAssertTrue(characterDetailsTableView.exists)

        characterDetailsTableView.swipeUp()
        characterDetailsTableView.swipeDown()
        
        wait(2.0)
        
        app.terminate()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
