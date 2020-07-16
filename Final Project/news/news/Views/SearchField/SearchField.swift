//
//  SearchField.swift
//  news
//
//  Created by Admin on 7/12/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import UIKit

class SearchField: UITextField {
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 15, y: 0, width: bounds.width, height: bounds.height)
        return super.editingRect(forBounds: newRect)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let newRect = CGRect(x: 15, y: 0, width: bounds.width, height: bounds.height)
        return super.editingRect(forBounds: newRect)
    }
}
