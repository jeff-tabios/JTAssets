//
//  APITests.swift
//  JTAssetsTests
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTAssets

class APITests: XCTestCase {

    
    func test_API(){
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        
        let sut = API(session: URLSession(configuration: configuration))
        
        var assets: Assets?
        
        let exp = expectation(description: "Get Assets")
        
        sut.request(endPoint: Endpoints.getData.endpoint,
                    completion: { (result: Result<Assets, APIServiceError>)  in
            
            switch result {
            case .success(let resultAssets):
                assets = resultAssets
            case .failure(let error):
                print(error)
                XCTAssert(false)
            }
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(assets?.data?.attributes?.cryptocoins?.count, 30)
    }
    
}
