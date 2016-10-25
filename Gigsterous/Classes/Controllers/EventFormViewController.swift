//
//  EventFormViewController.swift
//  Gigsterous
//
//  Created by Michal Švácha on 06/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

class EventFormViewController: UITableViewController {
    let event = Event()
    
    /// Instance variable keeping track of whether or not a date cell is expanded.
    ///
    /// - didSet: Subscribed to the value change and changes the enabled state of the Done button in order to prevent the user from submitting incomplete form.
    var isDateExpanded = false {
        didSet {
            self.navigationItem.rightBarButtonItem?.isEnabled = !isDateExpanded
        }
    }
    var expandedIndexPath = IndexPath(row: 0, section: 0)
    
    let structure = [
        ["sectionName": "GENERAL",
         "cells": [
            ["name": "NAME", "type": "textInput"],
            ["name": "VENUE", "type": "textInput"]]
        ],
        ["sectionName": "DATES",
         "cells": [
            ["name": "DATE_FROM", "type": "dateInput"],
            ["name": "DATE_TO", "type": "dateInput"]]
        ],
        ["sectionName": "ATTENDEES",
         "cells": [
            ["name": "ADD_ATTENDEE", "type": "addInput"]]
        ],
        ["sectionName": "AUDITIONS",
         "cells": [
            ["name": "ADD_AUDITION", "type": "addInput"]]
        ],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = NSLocalizedString("NEW_EVENT", comment: "")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(EventFormViewController.cancelButtonPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(EventFormViewController.doneButtonPressed))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cancelButtonPressed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func doneButtonPressed() {
        if self.event.isComplete() {
            print("I AM COMPLETE!")
        } else {
            let alertController = UIAlertController(
                title: NSLocalizedString("WARNING", comment: ""),
                message: NSLocalizedString("EMPTY_FIELDS", comment: ""),
                preferredStyle: .alert)
            alertController.addAction(UIAlertAction(
                title: NSLocalizedString("CLOSE", comment: ""),
                style: .cancel,
                handler: nil))
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.structure.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cells = self.structure[section]["cells"] as? [[String : String]] {
            return cells.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isDateExpanded && indexPath.isEqual(other: self.expandedIndexPath) {
            return 255
        }
        
        return 55
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.structure[section]["sectionName"] as? String
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cells = self.structure[indexPath.section]["cells"] as? [[String : String]] else {
            fatalError("Cell identifier not found")
        }
        let identifier = cells[indexPath.row]["type"]!
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = tableView.cellForRow(at: indexPath) as? DateTableViewCell {
            if self.isDateExpanded && !(indexPath.isEqual(other: self.expandedIndexPath)) {
                self.isDateExpanded = !self.isDateExpanded
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
            
            self.isDateExpanded = !self.isDateExpanded
            self.expandedIndexPath = indexPath
            
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
