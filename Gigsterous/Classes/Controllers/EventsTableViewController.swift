//
//  EventsTableViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

/// Events screen showing user's events, but also relevated events nearby.
class EventsTableViewController: UITableViewController {
    var customRefreshControl: UIRefreshControl!
    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("EVENTS", comment: "")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(EventsTableViewController.addButtonPressed))
        
        self.customRefreshControl = UIRefreshControl()
        self.customRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL2REFRESH", comment: ""))
        self.customRefreshControl.addTarget(self, action: #selector(EventsTableViewController.refreshControlPulled), for: UIControlEvents.valueChanged)
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
    
    /// Called after the add button in the navigation bar has been pressed. Creates and displays a form for adding a new event.
    func addButtonPressed() {
        if let formViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventFormController") {
            let navigationController = NavigationViewController(rootViewController: formViewController)
            self.tabBarController?.present(navigationController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Internal methods
    
    /// Gets called after UIRefreshControl has been pulled and released. Performs update of the UI - downloads the latest data, saves it and refreshes the UI.
    ///
    /// - Parameter success: Optional closure performed after loading has been performed.
    func refreshData(success: (() -> Void)?) {
        ClientMock.sharedInstance.events({ (events: [Event]) in
            self.events = events
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
        return self.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath as IndexPath)
        let eventData = self.events[indexPath.row]
        
        if let header = cell.viewWithTag(1) as? UILabel {
            header.text = String(eventData.name)
        }
        
        if let venue = cell.viewWithTag(2) as? UILabel {
            venue.text = eventData.venue
        }
        
        if let date = cell.viewWithTag(3) as? UILabel {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            date.text = dateFormatter.string(from: eventData.startDate)
        }
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero

        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
