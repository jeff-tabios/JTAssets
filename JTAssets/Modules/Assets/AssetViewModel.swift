//
//  AssetViewModel.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/4/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

protocol AssetDetail {
    var asset: Asset {get set}
    var icon: URL? { get }
    var name: String? { get }
    var symbol: String? { get }
    var avgPrice: String? { get }
    var type: String? { get }
    
}

extension AssetDetail {
    var icon: URL? {
        var iconResult = asset.attributes?.logo
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                iconResult = asset.attributes?.logoDark
            }
        }
        return URL(string: (iconResult)!)
    }
    
    var name: String? {
        return asset.attributes?.name
    }
    
    var symbol: String? {
        return asset.attributes?.symbol
    }
    
    var avgPrice: String? {
        return asset.attributes?.avgPrice?.formattedCurrency
    }
    
    var type: String? {
        return asset.type?.rawValue.capitalized
    }
}

struct AssetViewModel: AssetDetail {
    var asset: Asset
    
    public init(asset: Asset){
        self.asset = asset
    }
}
