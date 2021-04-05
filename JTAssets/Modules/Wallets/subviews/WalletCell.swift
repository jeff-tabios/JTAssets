//
//  WalletCell.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class WalletCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var defaultMark: UILabel!
    
    var vm: WalletViewModel?{
        didSet{
            if let logo = vm?.icon {
                icon.downloadedSVG(from: logo)
            }
            symbol.text = vm?.symbol
            name.text = vm?.name
            balance.text = vm?.balance

            if let isDefault = vm?.isDefault, isDefault {
                defaultMark.isHidden = false
            } else {
                defaultMark.isHidden = true
            }
            
            backgroundColor = vm?.bgColor
        }
    }
}
