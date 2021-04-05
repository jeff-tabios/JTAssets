//
//  MenuViewModel.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class MenuViewModel: NSObject {
    var api: APIProtocol?
    var assetViewModels: [AssetViewModel] = []
    var acquiredList: ((DataAttributes)-> Void)?
    var failGetList: (()-> Void)?
    
    override init(){
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        self.api = API(session: URLSession(configuration: configuration))
    }
    
    func getData() {

        api?.request(endPoint: Endpoints.getData.endpoint,
                     completion: { [weak self] (result: Result<Assets, APIServiceError>)  in
            
            switch result {
            case .success(let assets):
                
                if let data = assets.data?.attributes {
                    self?.acquiredList?(data)
                }
                
            case .failure(_):
                self?.failGetList?()
            }
        })
    }
}
