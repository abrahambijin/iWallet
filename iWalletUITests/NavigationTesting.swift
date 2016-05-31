//
//  NavigationTesting.swift
//  iWallet
//
//  Created by Bijin on 11/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import XCTest

class NavigationTesting: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        let accountsButton = tabBarsQuery.buttons["Accounts"]
        accountsButton.tap()
        tabBarsQuery.buttons["Settings"].tap()
        accountsButton.tap()
        app.navigationBars["Accounts"].buttons["Plus"].tap()
        app.navigationBars["iWallet.AddAccountView"].buttons["Cancel"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Wallet:"].tap()
        tablesQuery.staticTexts["Alex"].tap()
        app.navigationBars["Edit Transaction"].buttons["Cancel"].tap()
        app.navigationBars["Wallet"].buttons["Accounts"].tap()
        tablesQuery.staticTexts["Cash:"].tap()
        app.navigationBars["Cash"].buttons["Accounts"].tap()
        tabBarsQuery.buttons["Home"].tap()
        
    }
    
}
