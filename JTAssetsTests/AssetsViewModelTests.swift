//
//  AssetsViewModelTests.swift
//  JTAssetsTests
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTAssets

class AssetsViewModelTests: XCTestCase {

    override func setUp() {
        let sut = MenuViewModel()
        
        let exp = expectation(description: "Get Data")
        
        sut.acquiredList = { (assets) in
            AssetsManager.shared.assets = assets
            exp.fulfill()
        }
        
        sut.getData()
        
        waitForExpectations(timeout: 3)
       
    }
    
    func test_reload() {
        let sut = AssetsViewModel()
        sut.reload(with: .cryptocoin)
        
        XCTAssertEqual(sut.assetViewModels.count, 30)
    }
    
    func test_CryptoData() {
        let sut = AssetsViewModel()
        sut.reload(with: .cryptocoin)
        
        XCTAssertEqual(sut.assetViewModels[0].symbol, "BTC")
        XCTAssertEqual(sut.assetViewModels[0].name, "Bitcoin")
        XCTAssertEqual(sut.assetViewModels[0].avgPrice, "8936.50")
    }
    
    func test_CommodityData() {
        let sut = AssetsViewModel()
        sut.reload(with: .commodity)
        
        XCTAssertEqual(sut.assetViewModels[0].symbol, "XAU")
        XCTAssertEqual(sut.assetViewModels[0].name, "Gold")
        XCTAssertEqual(sut.assetViewModels[0].avgPrice, "46.20")
    }
    
    func test_FiatData() {
        let sut = AssetsViewModel()
        sut.reload(with: .fiat)
        
        XCTAssertEqual(sut.assetViewModels[0].symbol, "EUR")
        XCTAssertEqual(sut.assetViewModels[0].name, "Euro")
    }
    
}
