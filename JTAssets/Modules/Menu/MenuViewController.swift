//
//  MenuViewController.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

final class MenuViewController: UIViewController {
    
    @IBOutlet weak var assetsButton: UIButton!
    @IBOutlet weak var walletsButton: UIButton!
    var viewModel = MenuViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assetsButton.layer.cornerRadius = 126
        walletsButton.layer.cornerRadius = 126
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    func setupView() {
        viewModel.getData()
        
        viewModel.acquiredList = { (assets) in
            AssetsManager.shared.assets = assets
        }
        
        viewModel.failGetList = { () in
            print("Failed")
        }
    }
}
