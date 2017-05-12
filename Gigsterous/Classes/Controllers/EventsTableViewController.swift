//
//  EventsTableViewController.swift
//  Gigsterous
//
//  Created by Svacha, Michal on 17/08/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit
import Bond

/// Events screen showing user's events, but also relevated events nearby.
class EventsTableViewController: UITableViewController {
    var customRefreshControl: UIRefreshControl!
    let viewModel = EventsTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = NSLocalizedString("EVENTS", comment: "")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.rightBarButtonItem = addButton
        _ = addButton.reactive.tap.observeNext {
            if let formViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventFormController") {
                let navigationController = NavigationViewController(rootViewController: formViewController)
                self.tabBarController?.present(navigationController, animated: true, completion: nil)
            }
        }
        
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
        
        self.viewModel.events.bind(to: self.tableView) { evs, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath as IndexPath)
            let eventData = evs[indexPath.row]
            
            if let header = cell.viewWithTag(1) as? UILabel {
                header.text = String(eventData.name)
            }
            
            if let venue = cell.viewWithTag(2) as? UILabel {
                venue.text = eventData.venue.name
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
        
        customRefreshControl = UIRefreshControl()
        customRefreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("PULL2REFRESH", comment: ""))
        _ = customRefreshControl.reactive.controlEvents(UIControlEvents.valueChanged).observeNext {
            self.viewModel.refreshData(reload: true) {
                self.customRefreshControl.endRefreshing()
            }
        }
        tableView.addSubview(customRefreshControl)
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
