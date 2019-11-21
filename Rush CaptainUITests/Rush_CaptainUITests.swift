//
//  Rush_CaptainUITests.swift
//  Rush CaptainUITests
//
//  Created by Ryan Cobelli on 11/20/19.
//  Copyright © 2019 rybel-llc. All rights reserved.
//

import XCTest

class Rush_CaptainUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        
		let app = XCUIApplication()
		app.launchArguments += [ "testing" ]
		setupSnapshot(app)
		app.launch()
		
	}

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()
		
		let addButton = app.navigationBars["Rush Captain"].buttons["Add"]
		
		addButton.tap()
		app.textFields["nameInput"].typeText("Kate Bell\n")
		sleep(2)
		addButton.tap()
		app.textFields["nameInput"].typeText("John Appleseed\n")
		sleep(4)
		app.tables["mainTable"].staticTexts["Kate Bell"].tap()
		app.textFields["nameInput"].typeText("Tim Apple\n")
		
		sleep(7)
		snapshot("main")
    }
}
