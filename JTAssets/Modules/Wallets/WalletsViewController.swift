//
//  WalletsViewController.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

final class WalletsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = WalletsViewModel()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    func setupViews() {
        viewModel.getWallets()
        
        //Closure calls
        viewModel.refreshList = { () in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
