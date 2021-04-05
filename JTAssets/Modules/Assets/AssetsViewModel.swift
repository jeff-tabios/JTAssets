//
//  AssetsViewModel.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

protocol Filterable {
    var type: AssetType? {get set}
    func reload(with type: AssetType?)
    func getAssets()
}

class AssetsViewModel: NSObject, Filterable {
    var type: AssetType?
    
    var assetViewModels: [AssetViewModel] = []
    var refreshList: (()-> Void)?
    
    func reload(with type: AssetType? = nil) {
        self.type = type
        assetViewModels = []
        getAssets()
    }
    
    func getAssets() {

        if let cryptos = AssetsManager.shared.assets?.cryptocoins,
            let commodities = AssetsManager.shared.assets?.commodities,
            let fiats = AssetsManager.shared.assets?.fiats {
            
            if type == nil || type == .cryptocoin {
                assetViewModels += cryptos.map{AssetViewModel(asset: $0)}
            }
            
            if type == nil || type == .commodity {
                assetViewModels += commodities.map{AssetViewModel(asset: $0)}
            }
            
            if type == nil || type == .fiat {
                assetViewModels +=
                    fiats.filter{ $0.attributes?.hasWallets ?? false }.map{AssetViewModel(asset: $0)}
            }
            
            refreshList?()
        }
    }
}
