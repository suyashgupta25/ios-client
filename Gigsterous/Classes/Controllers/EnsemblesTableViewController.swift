//
//  EnsemblesTableViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/// Ensembles screen showing user's associated acts.
class EnsemblesTableViewController: UITableViewController {
    var customRefreshControl: UIRefreshControl!
    var ensembles: [Ensemble] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("ENSEMBLES", comment: "")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.customRefreshControl = UIRefreshControl()
        self.customRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL2REFRESH", comment: ""))
        self.customRefreshControl.addTarget(self, action: #selector(EnsemblesTableViewController.refreshControlPulled), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(customRefreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.refreshData(success: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        ClientMock.sharedInstance.ensembles({ (ensembles: [Ensemble]) in
            self.ensembles = ensembles
            self.tableView.reloadData()
            success?()
        }) { (error: NSError) in
            print("doh")
            success?()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ensembles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ensembleCell", for: indexPath as IndexPath)
        let ensembleData = self.ensembles[indexPath.row]
        
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
}
