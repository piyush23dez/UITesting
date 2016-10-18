//
//  UnitTestingDemoTests.swift
//  UnitTestingDemoTests
//
//  Created by Piyush on 8/21/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import XCTest

@testable import UnitTestingDemo

class UnitTestingDemoTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyBoard.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPercentage() {
        let percent = vc.getPercentage(80, 50)
        XCTAssert(percent == 40.0)
    }
    
    func testResultValue() {
        
        let _ = vc.view
        vc.updateLabels(80, percentvalue: 50, resultValue: 40)
        
        XCTAssert(vc.number.text! == "80.0","number is not correct")
        XCTAssert(vc.percent.text! == "50.0%","percent is not correct")
        XCTAssert(vc.result.text! == "40.0","result is not correct")
    }
    
    func testTable() {
        
        let table = XCUIApplication().tables
        
        table.staticTexts["Groceries"].tap()
        
        let addItemTextField = table.textFields["Add Item"]
        addItemTextField.tap()
        addItemTextField.typeText("Cookies")
        addItemTextField.typeText("\r")
        
        let cookiebutton = table.buttons["Cookies"]
        XCTAssertEqual(cookiebutton.value as! String, "0")
        cookiebutton.tap()
        XCTAssertEqual(cookiebutton.value as! String, "1")
    }
    
   func removeAllItems() {
        let app = XCUIApplication()
        let table = app.tables
        
        table.staticTexts["Groceries"].tap()
        app.navigationBars.staticTexts["Groceries"].buttons["Edit"].tap()
       
        while table.cells.count > 1 {
            let count = table.cells.count
            
            let cell = table.cells.element(boundBy: 0)
            cell.buttons.matching( NSPredicate(format: "label BEGINSWITH 'Delete'")).element.tap()
            cell.children(matching: .button).matching(identifier: "Delete").element(boundBy: 0).tap()
            
            XCTAssertEqual(Int(table.cells.count), Int(count) - 1)
        }
    }
    
    func testOtherButtonChangesFooter() {
        let app = XCUIApplication()
        
        // Define the expectation on the final UI state
        let expectedText = "Oh! Did something happen?!"
        let labelIdentifier = "footer label"
        let testPredicate = NSPredicate(format: "label = '\(expectedText)'")
        let object = app.staticTexts.element(matching: .any, identifier: labelIdentifier)
        
        self.expectation(for: testPredicate, evaluatedWith: object, handler: nil)
        
        // Act on the UI to change the state
        app.buttons["Press me and I'll do something, eventually"].tap()
        
        // Wait and see...
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}



