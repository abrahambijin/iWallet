//
//  AddAccountTesting.swift
//  iWallet
//
//  Created by Bijin on 11/04/2016.
//  Copyright © 2016 Bijin Abraham Idicula. All rights reserved.
//

import XCTest

class AddAccountTesting: XCTestCase {
        
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
        app.tabBars.buttons["Accounts"].tap()
        
        let plusButton = app.navigationBars["Accounts"].buttons["Plus"]
        plusButton.tap()
        
        let element2 = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        let element = element2.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        let textField = element.childrenMatchingType(.TextField).elementBoundByIndex(0)
        textField.tap()
        textField.typeText("wer")
        
        let saveButton = app.navigationBars["iWallet.AddAccountView"].buttons["Save"]
        saveButton.tap()
        plusButton.tap()
        textField.tap()
        
        let textField2 = element.childrenMatchingType(.TextField).elementBoundByIndex(1)
        textField2.tap()
        textField2.typeText("258")
        saveButton.tap()
        plusButton.tap()
        element2.tap()
        textField.tap()
        textField.typeText("tyh")
        textField2.tap()
        textField2.typeText("258")
        saveButton.tap()
        
    }
    
}
