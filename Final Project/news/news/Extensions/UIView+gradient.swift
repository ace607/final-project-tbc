//
//  UIView+gradient.swift
//  news
//
//  Created by Admin on 7/11/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.name = "gradient"
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
