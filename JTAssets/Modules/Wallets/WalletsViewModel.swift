//
//  WalletsViewModel.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class WalletsViewModel: NSObject {
    
    var refreshList: (()-> Void)?
    var walletViewModels: [WalletList] = []
    
    func getWallets() {
        if let cryptos = AssetsManager.shared.assets?.wallets,
           let commodities = AssetsManager.shared.assets?.commodityWallets,
           let fiats = AssetsManager.shared.assets?.fiatwallets {
                
                //Filter
                var cryptosWallet = cryptos.filter({ (wallet) -> Bool in
                    if let deleted = wallet.attributes?.deleted {
                        return !deleted
                    } else {
                        return true
                    }
                })
                               
                var commoditiesWallet = commodities.filter({ (wallet) -> Bool in
                    if let deleted = wallet.attributes?.deleted {
                        return !deleted
                    } else {
                        return true
                    }
                })
                  
                var fiatsWallet = fiats.filter({ (wallet) -> Bool in
                    if let deleted = wallet.attributes?.deleted {
                        return !deleted
                    } else {
                        return true
                    }
                })
               
                //Sort Descending
                cryptosWallet = cryptosWallet.sorted { (walletA, walletB) -> Bool in
                    if let bal1 = walletA.attributes?.balance,
                        let bal2 = walletB.attributes?.balance,
                        let bal1Val = Decimal(string: bal1),
                        let bal2Val = Decimal(string: bal2) {
                        
                        return bal1Val > bal2Val
                    }
                    return false
                }

                commoditiesWallet = commoditiesWallet.sorted { (walletA, walletB) -> Bool in
                 if let bal1 = walletA.attributes?.balance,
                     let bal2 = walletB.attributes?.balance,
                     let bal1Val = Decimal(string: bal1),
                     let bal2Val = Decimal(string: bal2) {
                     
                     return bal1Val > bal2Val
                 }
                 return false
                }
                 
                fiatsWallet = fiatsWallet.sorted { (walletA, walletB) -> Bool in
                  if let bal1 = walletA.attributes?.balance,
                      let bal2 = walletB.attributes?.balance,
                      let bal1Val = Decimal(string: bal1),
                      let bal2Val = Decimal(string: bal2) {
                      
                      return bal1Val > bal2Val
                  }
                  return false
                }
            
                //Create models
                let cryptosWalletList = WalletList(name: "Cryptocurrencies",
                                           wallets: cryptosWallet.map{WalletViewModel(wallet: $0)})
                let commoditiesWalletList = WalletList(name: "Commodities",
                                               wallets: commoditiesWallet.map{WalletViewModel(wallet: $0)})
                let fiatsWalletList = WalletList(name: "Fiats",
                                         wallets: fiatsWallet.map{WalletViewModel(wallet: $0)})

                walletViewModels.append(cryptosWalletList)
                walletViewModels.append(commoditiesWalletList)
                walletViewModels.append(fiatsWalletList)

                refreshList?()
       }
    }
}
