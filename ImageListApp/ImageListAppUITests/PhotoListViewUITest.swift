//
//  PhotoListViewUITest.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import XCTest

final class PhotoListViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testBasicElements() {
        XCTAssertTrue(app.navigationBars["Saved Photos"].exists, "Navigation title should be visible")
        let addButton = app.buttons["Add Photo"]
        XCTAssertTrue(addButton.exists, "Add Photo button should exist")
        XCTAssertTrue(addButton.isEnabled, "Add Photo button should be enabled")
        
    }
}
