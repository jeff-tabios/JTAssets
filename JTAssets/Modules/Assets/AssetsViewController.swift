//
//  AssetsViewController.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

final class AssetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterView: UIView!
    
    var viewModel = AssetsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        hideFilter(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupViews()
    }
    
    func setupViews(){
        viewModel.getAssets()
        
        //Closure calls
        viewModel.refreshList = { () in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func showFilter(_ sender: Any) {
        showFilter()
    }
    
    @IBAction func showAll(_ sender: Any) {
        viewModel.reload()
        hideFilter()
    }
    
    @IBAction func showCryptoOnly(_ sender: Any) {
        viewModel.reload(with: .cryptocoin)
        hideFilter()
    }
    
    @IBAction func showCommoditiesOnly(_ sender: Any) {
        viewModel.reload(with: .commodity)
        hideFilter()
    }
    
    @IBAction func showFiatsOnly(_ sender: Any) {
        viewModel.reload(with: .fiat)
        hideFilter()
    }
    
    private func hideFilter(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: {
                self.filterView.transform = CGAffineTransform(translationX: 0.0, y: -self.filterView.frame.size.height - 20)
            }) { (_) in
                self.filterView.isHidden = true
            }
        } else {
            self.filterView.transform = CGAffineTransform(translationX: 0.0, y: -self.filterView.frame.size.height - 20)
            filterView.isHidden = true
        }
    }
    
    private func showFilter() {
        filterView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.filterView.transform = CGAffineTransform.identity
        }
    }
    
    private func updateUI() {
        filterView.layer.cornerRadius = 5
        filterView.layer.shadowPath = UIBezierPath(rect: filterView.bounds).cgPath
        filterView.layer.shadowRadius = 5
        filterView.layer.shadowOffset = .zero
        filterView.layer.shadowOpacity = 0.2
    }
}
