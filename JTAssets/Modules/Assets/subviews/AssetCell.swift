//
//  AssetCell.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/5/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class AssetCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var avgPrice: UILabel!
    
    var vm: AssetViewModel?{
        didSet{
            icon.downloadedSVG(from: (vm?.icon)!)
            symbol.text = vm?.symbol
            name.text = vm?.name
            type.text = vm?.type
            avgPrice.text = vm?.avgPrice
        }
    }
}
