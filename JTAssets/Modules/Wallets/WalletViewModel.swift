//
//  WalletViewModel.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

protocol WalletDetail {
    var wallet: Wallet {get set}
    var icon: URL? { get }
    var name: String? { get }
    var symbol: String? { get }
    var balance: String? { get }
}

extension WalletDetail {
    var icon: URL? {
        var symbolType = wallet.attributes?.cryptocoinSymbol
        
        if wallet.type == .fiatWallet {
            symbolType = wallet.attributes?.fiatSymbol
        }
        
        guard let symbol = symbolType,
        let logo = AssetsManager.shared.logos[symbol] else { return nil }
        
        var iconResult = logo[0]
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                iconResult = logo[1]
            }
        }
        
        return URL(string: iconResult)
    }
    
    var name: String? {
        return wallet.attributes?.name
    }
    
    var symbol: String? {
        var symbolType = wallet.attributes?.cryptocoinSymbol
        
        if wallet.type == .fiatWallet {
            symbolType = wallet.attributes?.fiatSymbol
        }
        return symbolType
    }
    
    var balance: String? {
        return wallet.attributes?.balance
    }
    
    var isDefault: Bool? {
        wallet.attributes?.isDefault
    }
    
    var bgColor: UIColor? {
        var bgColor = UIColor.clear
        
        if wallet.type == .fiatWallet {
            bgColor = UIColor.systemOrange
        }
        return bgColor
    }
}

struct WalletViewModel: WalletDetail {
    var wallet: Wallet
    
    public init(wallet: Wallet){
        self.wallet = wallet
    }
}
