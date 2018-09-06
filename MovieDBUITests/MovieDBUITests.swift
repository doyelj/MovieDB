//
//  MovieDBUITests.swift
//  MovieDBUITests
//
//  Created by Doyel Joboy on 9/6/18.
//  Copyright © 2018 UST. All rights reserved.
//

import XCTest

class MovieDBUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
       // XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        app.launch()
        
        // Assert that we are displaying the tableview
        let movieTableView = app.tables["table--movieTableView"]
        
        XCTAssertTrue(movieTableView.exists, "The movie tableview exists")
        
        // Get an array of cells
        let tableCells = movieTableView.cells
                print("Count of table cells \(tableCells.count)")
        
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                tableCell.tap()
                // Trying to make the first cell as favourite.
                if i == 0 {
                    tableCell.buttons["favouritebutton"].tap()
                }
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                               // app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
    
}
