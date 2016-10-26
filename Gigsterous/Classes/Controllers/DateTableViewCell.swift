//
//  DateTableViewCell.swift
//  Gigsterous
//
//  Created by Michal Švácha on 18/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

///
protocol DateTableViewCellDelegate {
    ///
    func onDidChangeDate(date: Date, row: Int)
}

///
class DateTableViewCell: UITableViewCell {
    /// Variable indicating position.
    var row: Int = 0
    var delegate: DateTableViewCellDelegate?
    
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let datePicker = self.viewWithTag(3) as? UIDatePicker {
            datePicker.addTarget(self, action: #selector(DateTableViewCell.onDidChangeDate(datePicker:)), for: .valueChanged)
            datePicker.minimumDate = Date()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    ///
    private func setLabelText(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        let label = self.viewWithTag(2) as? UILabel
        label?.text = dateString
    }
    
    func setDate(date: Date) {
        if let datePicker = self.viewWithTag(3) as? UIDatePicker {
            datePicker.setDate(date, animated: false)
            self.setLabelText(date: date)
        }
    }

    // MARK: - UIDatePicker selector method
    
    ///
    func onDidChangeDate(datePicker: UIDatePicker) {
        self.setLabelText(date: datePicker.date)
        self.delegate?.onDidChangeDate(date: datePicker.date, row: self.row)
    }
}
