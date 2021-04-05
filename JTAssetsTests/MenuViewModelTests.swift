//
//  MenuViewModelTests.swift
//  JTAssetsTests
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTAssets

class MenuViewModelTests: XCTestCase {

    func test_getData() {
        let sut = MenuViewModel()
        
        let exp = expectation(description: "Get Data")
        
        sut.acquiredList = { (assets) in
            AssetsManager.shared.assets = assets
            exp.fulfill()
        }
        
        sut.getData()
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(AssetsManager.shared.assets?.cryptocoins?.count, 30)
    }

}
