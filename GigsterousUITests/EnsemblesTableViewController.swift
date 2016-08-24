//
//  EnsemblesTableViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/**
 Ensembles screen showing user's associated acts.
 */
class EnsemblesTableViewController: UITableViewController {
    var customRefreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("ENSEMBLES", comment: "")
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.customRefreshControl = UIRefreshControl()
        self.customRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL2REFRESH", comment: ""))
        self.customRefreshControl.addTarget(self, action: #selector(EnsemblesTableViewController.refreshControlPulled), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(customRefreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBActions
    
    /**
     Selector method called when UIRefreshControl is pulled.
     */
    func refreshControlPulled() {
        // Show loading bar
        self.refreshData {
            // Hide loading bar
            self.customRefreshControl.endRefreshing()
        }
    }
    
    // MARK: - Internal methods
    
    /**
     Gets called after UIRefreshControl has been pulled and released. Performs update of the UI - downloads the latest data, saves it and refreshes the UI.
     
     - parameter success: Optional closure performed after loading has been performed.
     */
    func refreshData(success: (() -> Void)?) {
        // Data loading and setting
        success?()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ensembleCell", forIndexPath: indexPath)
        
        // Cell setup
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
    }
}
