//
//  WalletList.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class WalletList {
    let name: String?
    let wallets: [WalletViewModel]?
    
    init(name: String?, wallets: [WalletViewModel]?) {
        self.name = name
        self.wallets = wallets
    }
}
