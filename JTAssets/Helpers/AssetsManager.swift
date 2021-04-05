//
//  AssetsManager.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/4/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

struct AssetsManager {
    static var shared = AssetsManager()
    var assets: DataAttributes? {
        didSet {
            mapLogos()
        }
    }
    var logos: [String: [String]] = [:]

    private init() { }
    
    //Map logos to symbols in 2D. First item is always light version
    private mutating func mapLogos() {
        assets?.cryptocoins?.forEach({ (asset) in
            if let symbol = asset.attributes?.symbol,
                let logo = asset.attributes?.logo,
                let logoDark = asset.attributes?.logoDark {
                logos[symbol] = [logo, logoDark]
            }
        })
        
        assets?.commodities?.forEach({ (asset) in
            if let symbol = asset.attributes?.symbol,
                let logo = asset.attributes?.logo,
                let logoDark = asset.attributes?.logoDark {
                logos[symbol] = [logo, logoDark]
            }
        })
        
        assets?.fiats?.forEach({ (asset) in
            if let symbol = asset.attributes?.symbol,
                let logo = asset.attributes?.logo,
                let logoDark = asset.attributes?.logoDark {
                logos[symbol] = [logo, logoDark]
            }
        })
        
        
    }
}
