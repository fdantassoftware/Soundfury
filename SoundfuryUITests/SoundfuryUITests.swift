//
//  SoundfuryUITests.swift
//  SoundfuryUITests
//
//  Created by Fabio Dantas on 26/10/2016.
//  Copyright © 2016 DantasSoftware. All rights reserved.
//

import XCTest

class SoundfuryUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    

    
    func testExample() {
        
        
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["fsf"].tap()
        
        tablesQuery.cells.containing(.staticText, identifier:"Swswsw").staticTexts["October 26, 2016"].tap()
        app.buttons["New"].tap()
        app.buttons["startrecording"].tap()
        app.buttons["stoprecording"].tap()
        app.buttons["playbt 1"].tap()
        
        let nameTextField = app.textFields["Name"]
        nameTextField.tap()
        nameTextField.typeText("teste 12")
        app.typeText("3")
        tablesQuery.cells.containing(.staticText, identifier:"fsf").staticTexts["October 26, 2016"].tap()
        tablesQuery.staticTexts["Teste 123"].tap()
        
        
    }
    
}
