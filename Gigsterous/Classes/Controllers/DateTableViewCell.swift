//
//  DateTableViewCell.swift
//  Gigsterous
//
//  Created by Michal Švácha on 18/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let datePicker = self.viewWithTag(3) as? UIDatePicker {
            datePicker.addTarget(self, action: #selector(DateTableViewCell.onDidChangeDate(datePicker:)), for: .valueChanged)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func selectedDate() -> Date {
        if let datePicker = self.viewWithTag(3) as? UIDatePicker {
            return datePicker.date
        }
        
        return Date()
    }

    // MARK: - UIDatePicker selector method
    
    func onDidChangeDate(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = dateFormatter.string(from: datePicker.date)
        
        let label = self.viewWithTag(2) as? UILabel
        label?.text = dateString
    }
}
