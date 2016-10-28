//
//  InputTableViewCell.swift
//  Gigsterous
//
//  Created by Michal Švácha on 25/10/16.
//  Copyright © 2016 Svacha, Michal. All rights reserved.
//

import UIKit

///
protocol InputTableViewCellDelegate {
    
    ///
    func onFinishedTyping(text: String, row: Int)
}

///
class InputTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    /// Variable indicating position.
    var row: Int = 0
    var delegate: InputTableViewCellDelegate?
    
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let textField = self.viewWithTag(2) as? UITextField {
            textField.delegate = self
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - UITextField delegate method

    ///
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textField = self.viewWithTag(2) as? UITextField {
            textField.resignFirstResponder()
            let text = textField.text ?? ""
            self.delegate?.onFinishedTyping(text: text, row: self.row)
        }
        
        return true
    }
}
