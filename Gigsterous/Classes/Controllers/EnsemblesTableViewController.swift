//
//  EnsemblesTableViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit
import Bond

/// Ensembles screen showing user's associated acts.
class EnsemblesTableViewController: UITableViewController {
    var customRefreshControl: UIRefreshControl!
    let viewModel = EnsemblesTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("ENSEMBLES", comment: "")
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.refreshData(reload: true, success: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///
    func setupTableView() {
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.viewModel.ensembles.bind(to: self.tableView) { ens, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ensembleCell", for: indexPath as IndexPath)
            let ensembleData = ens[indexPath.row]
            
            if let name = cell.viewWithTag(1) as? UILabel {
                name.text = String(ensembleData.name)
            }
            
            if let ensembleType = cell.viewWithTag(2) as? UILabel {
                ensembleType.text = ensembleData.ensembleType
            }
            
            if let musicians = cell.viewWithTag(3) as? UILabel {
                musicians.text = "\(ensembleData.people.count) musicians"
            }
            
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            return cell
        }
        
        customRefreshControl = UIRefreshControl()
        customRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL2REFRESH", comment: ""))
        _ = customRefreshControl.reactive.controlEvents(UIControlEvents.valueChanged).observeNext {
            self.viewModel.refreshData(reload: true) {
                self.customRefreshControl.endRefreshing()
            }
        }
        tableView.addSubview(customRefreshControl)
    }
}
