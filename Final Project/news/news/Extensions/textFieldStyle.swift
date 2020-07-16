//
//  textFieldStyle.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

extension UITextField {
    
    func bottomBordered() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.withAlphaComponent(0.2).cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }

}
