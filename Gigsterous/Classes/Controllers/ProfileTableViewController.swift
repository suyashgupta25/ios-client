//
//  ProfileTableViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/// Personal profile of the user - all information on one screen.
class ProfileTableViewController: UITableViewController {
    var customRefreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("PROFILE", comment: "")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.customRefreshControl = UIRefreshControl()
        self.customRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL2REFRESH", comment: ""))
        self.customRefreshControl.addTarget(self, action: #selector(ProfileTableViewController.refreshControlPulled), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(customRefreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    /// Selector method called when UIRefreshControl is pulled.
    func refreshControlPulled() {
        // Show loading bar
        self.refreshData {
            // Hide loading bar
            self.customRefreshControl.endRefreshing()
        }
    }
    
    // MARK: - Internal methods
    
    /// Gets called after UIRefreshControl has been pulled and released. Performs update of the UI - downloads the latest data, saves it and refreshes the UI.
    ///
    /// - Parameter success: Optional closure performed after loading has been performed.
    func refreshData(success: (() -> Void)?) {
        // Data loading and setting
        success?()
    }

    // MARK: - Table view data source

    override func numberOfSections(in: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath as IndexPath)

        // Cell setup
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
}
