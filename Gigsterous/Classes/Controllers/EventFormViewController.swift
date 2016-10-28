//
//  EventFormViewController.swift
//  Gigsterous
//
//  Created by Michal Švácha on 06/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

///
class EventFormViewController: UITableViewController, DateTableViewCellDelegate, InputTableViewCellDelegate {
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
        
        self.event.name = NSLocalizedString("NEW_EVENT", comment: "")
        self.event.startDate = Date()
        self.event.endDate = self.event.startDate.addingTimeInterval(3600)

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
        if let sectionName = self.structure[section]["sectionName"] as? String {
            return NSLocalizedString(sectionName, comment: "")
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cells = self.structure[indexPath.section]["cells"] as? [[String : String]] else {
            fatalError("Cell structure not found")
        }
        let cellInfo = cells[indexPath.row]
        let identifier = cellInfo["type"]!
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch identifier {
            case "dateInput":
                let dateCell = cell as! DateTableViewCell
                dateCell.row = indexPath.row
                dateCell.delegate = self
                
                let date = indexPath.row == 0 ?
                    self.event.startDate : self.event.endDate
                dateCell.setDate(date: date!)
            break
            case "textInput":
                let inputCell = cell as! InputTableViewCell
                inputCell.row = indexPath.row
                inputCell.delegate = self
                
                if indexPath.row == 0 {
                    let textField = cell.viewWithTag(2) as! UITextField
                    textField.text = self.event.name
                }
            break
        default:
            break
        }
        
        if let label = cell.viewWithTag(1) as? UILabel, let labelText = cellInfo["name"] {
            label.text = NSLocalizedString(labelText, comment: "")
        }
        
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
    
    // MARK: - DateTableViewCell delegate method
    
    func onDidChangeDate(date: Date, row: Int) {
        let formerDifference = self.event.endDate.timeIntervalSince(self.event.startDate)
        
        if row == 0 {
            self.event.startDate = date
            
            if self.event.startDate.compare(self.event.endDate) != .orderedAscending {
                self.event.endDate = self.event.startDate.addingTimeInterval(formerDifference)
            }
        } else {
            self.event.endDate = date
            
            if self.event.startDate.compare(self.event.endDate) != .orderedAscending {
                var dateCandidate = self.event.endDate.addingTimeInterval(-formerDifference)
                if dateCandidate.compare(Date()) == .orderedAscending {
                    dateCandidate = Date()
                }
                
                self.event.startDate = dateCandidate
            }
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - InputTableViewCell delegate method
    
    func onFinishedTyping(text: String, row: Int) {
        if row == 0 {
            self.event.name = text
        } else {
            self.event.venue = text
        }
    }
}
