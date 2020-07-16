//
//  buttonStyle.swift
//  news
//
//  Created by Admin on 7/4/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import UIKit

extension UIButton {
    func rounded() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }
}
