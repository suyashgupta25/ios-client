//
//  EventFormViewController.swift
//  Gigsterous
//
//  Created by Michal Švácha on 06/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit
import Bond

/// Controller responsible for handling form for a new event.
class EventFormViewController: UITableViewController {
    let eventViewModel = EventFormViewModel()
    
    /// Instance variable keeping track of whether or not a date cell is expanded. If the value is nil, nothing is expanded.
    ///
    /// - didSet: Subscribed to the value change and changes the enabled state of the Done button in order to prevent the user from submitting an incomplete form.
    var expandedIndexPath: IndexPath? {
        didSet {
            self.navigationItem.rightBarButtonItem?.isEnabled = expandedIndexPath == nil
        }
    }
    
    // MARK: - Table view content structure
    
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
    
    /// Parses and returns the structure of a cell at given indexPath
    ///
    /// - Returns: Dictionary containing information about the cell.
    func cellInfo(for indexPath: IndexPath) -> [String : String] {
        guard let cells = self.structure[indexPath.section]["cells"] as? [[String : String]] else {
            fatalError("Cell structure not found")
        }
        
        return cells[indexPath.row]
    }
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventViewModel.name.bind(to: self.navigationItem.bnd_title)
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(EventFormViewController.cancelButtonPressed))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(EventFormViewController.doneButtonPressed))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBActions
    
    /// Dismisses the controller and returns user to the previous screen. Called when cancel button in the top left corner is pressed.
    func cancelButtonPressed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /// Checks whether information in the form is complete and proceeds with next steps. When information is not complete, warns the user. Called when done button in the top right corner is pressed.
    func doneButtonPressed() {
        if self.eventViewModel.isComplete() {
            self.navigationController?.dismiss(animated: true, completion: {
                // temporary
                let alertController = UIAlertController(
                    title: "Success",
                    message: "The form has been successfully filled. Awaiting REST API implementation.",
                    preferredStyle: .alert)
                alertController.addAction(UIAlertAction(
                    title: NSLocalizedString("CLOSE", comment: ""),
                    style: .cancel,
                    handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            })
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
        if let expanded = self.expandedIndexPath, expanded.isEqual(other: indexPath) {
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
        let cellInfo = self.cellInfo(for: indexPath)
        let identifier = cellInfo["type"]!
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch identifier {
            case "dateInput":
                let label = cell.viewWithTag(2) as! UILabel
                let datePicker = cell.viewWithTag(3) as! UIDatePicker
                datePicker.minimumDate = Date()
                
                if indexPath.row == 0 {
                    datePicker.setDate(self.eventViewModel.startDate.value, animated: false)
                    datePicker.bnd_date.bidirectionalBind(to: self.eventViewModel.startDate)
                    self.eventViewModel.startDate
                        .map{$0.humanReadableString()}
                        .bind(to: label.bnd_text)
                } else {
                    datePicker.setDate(self.eventViewModel.endDate.value, animated: false)
                    datePicker.bnd_date.bidirectionalBind(to: self.eventViewModel.endDate)
                    self.eventViewModel.endDate
                        .map{$0.humanReadableString()}
                        .bind(to: label.bnd_text)
                }
            break
            case "textInput":
                let textField = cell.viewWithTag(2) as! UITextField
                
                if indexPath.row == 0 {
                    textField.text = self.eventViewModel.name.value
                    textField.bnd_text.bind(to: self.eventViewModel.name)
                } else {
                    textField.text = self.eventViewModel.venue.value
                    textField.bnd_text.bind(to: self.eventViewModel.venue)
                }
            break
        default:
            break
        }
        
        /// Localization of labels
        if let label = cell.viewWithTag(1) as? UILabel, let labelText = cellInfo["name"] {
            label.text = NSLocalizedString(labelText, comment: "")
        }
        
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    /// Handles internal storage of currently expanded cell's indexPath. Called after an expandable (= date) cell has been pressed.
    func handleDateExpansion(indexPath: IndexPath) {
        if let expanded = self.expandedIndexPath, expanded.isEqual(other: indexPath) {
            self.expandedIndexPath = nil
        } else {
            self.expandedIndexPath = indexPath
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellInfo = self.cellInfo(for: indexPath)
        let identifier = cellInfo["type"]!
        
        if identifier == "dateInput" {
            self.handleDateExpansion(indexPath: indexPath)
        }
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
}
